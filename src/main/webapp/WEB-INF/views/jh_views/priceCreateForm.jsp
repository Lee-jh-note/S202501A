<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Price History Create Form</title>
  <style>
    /* 기본 스타일 */
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
    }

    .container {
      width: 50%;
      margin: 0 auto;
    }

    h2 {
      text-align: center;
      margin-bottom: 20px;
    }

    label {
      display: block;
      margin-top: 10px;
    }

    input, select {
      width: 100%;
      padding: 8px;
      margin: 5px 0 20px;
      border: 1px solid #ddd;
      border-radius: 5px;
    }

    button {
      background-color: #4CAF50;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      width: 100%;
      cursor: pointer;
    }

    button:hover {
      background-color: #45a049;
    }
  </style>
</head>
<body>

<div class="container">
  <h2>Price History Creation</h2>

  <form action="/Prod/PriceCreateAct" method="post">

    <!-- 제품 번호 선택 -->
    <label for="product_no">Product No</label>
    <select id="product_no" name="product_no" required>
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
      <option value="4">4</option>
      <option value="5">5</option>
      <option value="6">6</option>
      <option value="7">7</option>
      <option value="8">8</option>
      <option value="9">9</option>
      <option value="10">10</option>
    </select>

    <!-- 판매/구매 선택 -->
    <label for="sale_or_purchase">Sale or Purchase</label>
    <select id="sale_or_purchase" name="sale_or_purchase" required>
      <option value="0">Sale</option>
      <option value="1">Purchase</option>
    </select>

    <!-- 가격 입력 -->
    <label for="price">Price</label>
    <input type="number" id="price" name="price" required>

    <!-- 카테고리 선택 -->
    <label for="category">Category</label>
    <select id="category" name="category" required>
      <option value="500">500</option>
      <option value="510">510</option>
      <option value="520">520</option>
      <option value="530">530</option>
    </select>

    <!-- Submit 버튼 -->
    <button type="submit">Create Price History</button>
  </form>
</div>

</body>
</html>
