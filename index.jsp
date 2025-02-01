<<<<<<< HEAD
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Guess Game - New Random Each Time</title>
    <!-- Google Fonts: Orbitron for futuristic look -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500&display=swap" rel="stylesheet">

    <style>
        /* ========================= THEMES ========================= */
        body.theme-default {
            margin: 0;
            padding: 0;
            font-family: 'Orbitron', sans-serif;
            color: #fff;
            background: linear-gradient(135deg, #111, #222);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        body.theme-default .container {
            background: rgba(0,0,0,0.5);
            border: 2px solid #0ff;
            box-shadow: 0 0 20px #0ff;
            color: #fff;
        }
        body.theme-default .button {
            background: #0ff;
            color: #000;
        }
        body.theme-default .button:hover {
            background: #0cc;
        }
        body.theme-default .players-table thead {
            background: #0ff;
            color: #000;
        }
        body.theme-default .players-table tbody tr:hover {
            background: rgba(0, 255, 255, 0.2);
        }
        body.theme-default .start-over {
            color: #0ff;
        }
        body.theme-default .start-over:hover {
            color: #0cc;
        }

        /* ערכת צבע שנייה (alt) */
        body.theme-alt {
            margin: 0;
            padding: 0;
            font-family: 'Orbitron', sans-serif;
            color: #f0f0f0;
            background: linear-gradient(135deg, #300, #500);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        body.theme-alt .container {
            background: rgba(0,0,0,0.7);
            border: 2px solid #f0f;
            box-shadow: 0 0 20px #f0f;
            color: #f0f0f0;
        }
        body.theme-alt .button {
            background: #f0f;
            color: #000;
        }
        body.theme-alt .button:hover {
            background: #c0c;
        }
        body.theme-alt .players-table thead {
            background: #f0f;
            color: #000;
        }
        body.theme-alt .players-table tbody tr:hover {
            background: rgba(255, 0, 255, 0.2);
        }
        body.theme-alt .start-over {
            color: #f0f;
        }
        body.theme-alt .start-over:hover {
            color: #c0c;
        }

        /* =========== עיצוב כללי =========== */
        .container {
            border-radius: 10px;
            width: 700px;
            max-width: 90%;
            padding: 20px;
            margin-bottom: 40px;
        }
        h1 {
            margin-top: 50px;
            font-size: 3em;
            text-shadow: 0 0 10px currentColor;
            text-align: center;
        }
        .game-form {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .game-form input[type="text"] {
            padding: 10px;
            border: 2px solid currentColor;
            border-radius: 5px;
            background: #333;
            color: #fff;
            font-size: 1em;
            transition: box-shadow 0.3s ease;
        }
        .game-form input[type="text"]:focus {
            outline: none;
            box-shadow: 0 0 5px currentColor;
        }
        .button {
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-size: 1em;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .message {
            margin: 20px 0;
            font-size: 1.2em;
            text-align: center;
            min-height: 30px;
            text-shadow: 0 0 5px currentColor;
        }
        .players-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .players-table th, .players-table td {
            padding: 10px;
            border: 1px solid currentColor;
            text-align: center;
        }
        .players-table tbody tr:nth-child(even) {
            background: rgba(255, 255, 255, 0.05);
        }
        .start-over {
            display: inline-block;
            margin-top: 10px;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s;
        }
        .theme-toggle {
            position: absolute;
            top: 10px;
            right: 10px;
        }
    </style>
</head>
<body class="theme-default">
<%
    // --------------------------------
    // 1) הכנת מבנה נתונים ב-application (אם לא קיים):
    // --------------------------------
    if (application.getAttribute("playersList") == null) {
        List<String[]> initList = new ArrayList<>();
        application.setAttribute("playersList", initList);
    }
    List<String[]> playersList = (List<String[]>) application.getAttribute("playersList");

    // --------------------------------
    // 2) קריאת פרמטרים מהטופס:
    // --------------------------------
    String playerName = request.getParameter("playerName");
    String guessParam = request.getParameter("guess");
    if (playerName == null) playerName = "";
    String message = "";

    // --------------------------------
    // 3) בכל קליק על "Submit Guess" מייצרים מספר חדש:
    // --------------------------------
    if (guessParam != null && !guessParam.trim().isEmpty()) {
        try {
            int guess = Integer.parseInt(guessParam);

            // מספר אקראי "של המכונה" - חדש בכל פעם
            int machineNumber = new Random().nextInt(100) + 1; 

            String status;
            if (guess < 1 || guess > 100) {
                message = "Please guess a number between 1 and 100!";
                status = "Invalid Range";
            } else if (guess < machineNumber) {
                message = "Too low! (Machine's number was " + machineNumber + ")";
                status = "LOW";
            } else if (guess > machineNumber) {
                message = "Too high! (Machine's number was " + machineNumber + ")";
                status = "HIGH";
            } else {
                // guess == machineNumber
                message = "Correct! The machine's number was " + machineNumber + "!";
                status = "CORRECT";
            }

            // רושמים שורה בהיסטוריה: [name, guess, machineNumber, status, time]
            String timeStamp = new Date().toString();
            playersList.add(new String[] {
                playerName,
                String.valueOf(guess),
                String.valueOf(machineNumber),
                status,
                timeStamp
            });
            application.setAttribute("playersList", playersList);

        } catch (NumberFormatException e) {
            message = "Please enter a valid whole number!";
        }
    } else {
        message = "Enter your name and guess a number between 1 and 100.";
    }
%>

    <!-- כפתור החלפת ערכת נושא -->
    <div class="theme-toggle">
        <button class="button" type="button" onclick="toggleTheme()">Change Theme</button>
    </div>

    <h1>Guess Game - New Random Each Time</h1>

    <div class="container">
        <div class="message"><%= message %></div>

        <form class="game-form" method="POST" action="index.jsp">
            <input type="text" name="playerName" placeholder="Your Name" value="<%= playerName %>" />
            <input type="text" name="guess" placeholder="Your Guess (1 - 100)" />
            <button class="button" type="submit">Submit Guess</button>
        </form>

        <!-- כפתור "Start Over" אפשרי, אבל בפועל רק מרענן דף (לא משנה הרבה כי כל Guess הוא משחק חדש) -->
        <a class="start-over" href="index.jsp">Update</a>
    </div>

    <!-- טבלת היסטוריה - שומרת את כל הניחושים של כל המשתמשים -->
    <div class="container">
        <h2 style="text-align:center; text-shadow:0 0 5px currentColor;">Game History</h2>
        <table class="players-table">
            <thead>
                <tr>
                    <th>  Name </th>
<<<<<<< HEAD
                    <th> Guess</th>
                    <th> Number</th>
=======
                    <th>Player Guess</th>
                    <th>Machine Number</th>
>>>>>>> d6c8bf8180f37687373e856ebaf6c38dfb7fa2c7
                    <th>Result</th>
                    <th>Time</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (String[] entry : playersList) {
                    // הגנה על רשומות ישנות (אם היו בגודל 4)
                    String name       = (entry.length > 0) ? entry[0] : "";
                    String guess      = (entry.length > 1) ? entry[1] : "";
                    String machineNum = (entry.length > 2) ? entry[2] : "";
                    String stat       = (entry.length > 3) ? entry[3] : "";
                    String time       = (entry.length > 4) ? entry[4] : "";
            %>
                <tr>
                    <td><%= name %></td>
                    <td><%= guess %></td>
                    <td><%= machineNum %></td>
                    <td><%= stat %></td>
                    <td><%= time %></td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <script>
        // החלפת ערכת הנושא
        function toggleTheme() {
            let body = document.querySelector('body');
            if (body.classList.contains('theme-default')) {
                body.classList.remove('theme-default');
                body.classList.add('theme-alt');
            } else {
                body.classList.remove('theme-alt');
                body.classList.add('theme-default');
            }
        }
    </script>
=======
</body>
</html>
