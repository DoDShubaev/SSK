<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="he">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>צ'אט GPT</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e8f1ff;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 800px;
            border: 2px solid #0038a8;
            direction: rtl;
        }
        h1 {
            font-size: 28px;
            text-align: center;
            margin-bottom: 20px;
            color: #0038a8;
            font-weight: bold;
            text-transform: uppercase;
        }
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 2px solid #0038a8;
            border-radius: 5px;
            font-size: 16px;
            background-color: #f0f8ff;
            color: #0038a8;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #0038a8;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            font-weight: bold;
            text-transform: uppercase;
        }
        button:hover {
            background-color: #002070;
        }
        .results {
            margin-top: 20px;
            background: #f0f8ff;
            padding: 15px;
            border: 2px solid #0038a8;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .results h2 {
            color: #0038a8;
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .results p {
            font-size: 16px;
            color: #0038a8;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>צ'אט GPT</h1>
        <form method="post">
            <textarea name="question" placeholder="כתוב את השאלה שלך כאן..." rows="4"></textarea>
            <button type="submit">שלח</button>
        </form>
        <div class="results">
            <h2>תשובה:</h2>
            <p>כאן תופיע התשובה לאחר העיבוד.</p>
        </div>
    </div>
</body>
</html>
