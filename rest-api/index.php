<?php
header('Content-Type: application/json');
function connectDb(){
    $db = new PDO('mysql:host=localhost;dbname=my_store', 'root', '');
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    return $db;
}

function getProducts(){
    $db = connectDb();
    $stmt = $db->prepare('SELECT * FROM tb_item');
    $stmt->execute();
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($users);
}

function getProduct($id){
    $db = connectDb();
    $stmt = $db->prepare('SELECT * FROM tb_item WHERE id = :id');
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    echo json_encode($user);
}

function addProduct($item_code, $item_name, $price, $stock){
    $db = connectDb();
    $stmt = $db->prepare('INSERT INTO tb_item (item_code, item_name, price, stock) VALUES (:item_code, :item_name, :price, :stock)');
    $stmt->bindParam(':item_code', $item_code);
    $stmt->bindParam(':item_name', $item_name);
    $stmt->bindParam(':price', $price);
    $stmt->bindParam(':stock', $stock);
    $stmt->execute();
    
}

function updateProduct($id, $item_code, $item_name, $price, $stock){
    $db = connectDb();
    $stmt = $db->prepare('UPDATE tb_item SET item_code = :item_code, item_name = :item_name, price = :price, stock = :stock WHERE id = :id');
    $stmt->bindParam(':id', $id);
    $stmt->bindParam(':item_code', $item_code);
    $stmt->bindParam(':item_name', $item_name);
    $stmt->bindParam(':price', $price);
    $stmt->bindParam(':stock', $stock);
    $stmt->execute();
}

function deleteProduct($id){
    $db = connectDb();
    $stmt = $db->prepare('DELETE FROM tb_item WHERE id = :id');
    $stmt->bindParam(':id', $id);
    $stmt->execute();
}

if(isset($_GET['page']) && $_GET['page'] == "delete-product"){
    deleteProduct($_POST['id']);
} elseif (isset($_GET['page']) && $_GET['page'] == "add-product") {
    addProduct($_POST['item_code'], $_POST['item_name'], $_POST['price'], $_POST['stock']);
} elseif (isset($_GET['page']) && $_GET['page'] == "update-product") {
    updateProduct($_POST['id'], $_POST['item_code'], $_POST['item_name'], $_POST['price'], $_POST['stock']);
} else {
    getProducts();
}
