<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css">
    <style>
        header {
            text-align: center;
            margin-top: 30px;
        }
        header h2 {
            margin: 10px 15px;
            display: inline-block;
            font-size: 8px; /* 글씨 크기 줄이기 */
        }
        header a {
            text-decoration: none;
            color: #ffffff;
            background-color: #007bff;
            padding: 8px 16px;
            border-radius: 5px;
            font-size: 8px; /* 글씨 크기 줄이기 */
            transition: background-color 0.3s ease;
        }
        header a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<header>
    <h2><a href="/Prod/PriceList">가격 히스토리 리스트</a></h2>
    <h2><a href="/Prod/ProdList">제품 리스트</a></h2>
    <h2><a href="/Inven/InvenList">재고 리스트</a></h2>
    <h2><a href="/Recodes/List">실적</a></h2>
</header>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
