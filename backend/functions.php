<?php
define("MB", 1048576);

/*====================[ FILTER REQUEST ]====================*/
function filterRequest($key) {
    return isset($_POST[$key]) 
        ? htmlspecialchars(strip_tags($_POST[$key])) 
        : "";
}

/*====================[ PRINT RESPONSES ]====================*/
function printSuccess($data = null) {
    header('Content-Type: application/json');
    echo json_encode([
        "status" => "success",
        "data"   => $data
    ]);
    exit();
}

function printFailure($message = "خطأ غير معروف") {
    header('Content-Type: application/json');
    echo json_encode([
        "status"  => "failure",
        "message" => $message
    ]);
    exit();
}

/*====================[ DATABASE OPERATIONS ]====================*/
function getAllData($table, $where = null, $values = []) {
    global $con;
    $sql = "SELECT * FROM $table";
    if ($where) $sql .= " WHERE $where";

    $stmt = $con->prepare($sql);
    $stmt->execute($values);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function getData($table, $where = null, $values = []) {
    global $con;
    $sql = "SELECT * FROM $table";
    if ($where) $sql .= " WHERE $where";

    $stmt = $con->prepare($sql);
    $stmt->execute($values);

    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function insertData($table, $data) {
    global $con;
    $fields = implode(',', array_keys($data));
    $placeholders = ':' . implode(', :', array_keys($data));
    $sql = "INSERT INTO $table ($fields) VALUES ($placeholders)";
    $stmt = $con->prepare($sql);

    foreach ($data as $key => $val) {
        $stmt->bindValue(":$key", $val);
    }

    $stmt->execute();
    return $stmt->rowCount() > 0;
}

function updateData($table, $data, $where) {
    global $con;
    $cols = [];
    foreach ($data as $key => $val) $cols[] = "`$key` = ?";
    $sql = "UPDATE $table SET " . implode(', ', $cols) . " WHERE $where";
    $stmt = $con->prepare($sql);
    $stmt->execute(array_values($data));
    return $stmt->rowCount() > 0;
}

function deleteData($table, $where, $values = []) {
    global $con;
    $stmt = $con->prepare("DELETE FROM $table WHERE $where");
    $stmt->execute($values);
    return $stmt->rowCount() > 0;
}

/*====================[ IMAGE UPLOAD / DELETE ]====================*/
function imageUpload($dir, $inputName) {
    global $msgError;
    if (!isset($_FILES[$inputName])) return 'empty';

    $imageName = rand(1000, 9999) . $_FILES[$inputName]['name'];
    $tmp = $_FILES[$inputName]['tmp_name'];
    $size = $_FILES[$inputName]['size'];
    $ext = strtolower(pathinfo($imageName, PATHINFO_EXTENSION));
    $allowed = ['jpg','png','gif','pdf','svg','mp3'];

    if (!in_array($ext, $allowed)) return "fail";
    if ($size > 2 * MB) return "fail";

    move_uploaded_file($tmp, "$dir/$imageName");
    return $imageName;
}

function deleteFile($dir, $name) {
    $path = "$dir/$name";
    if (file_exists($path)) unlink($path);
}

/*====================[ AUTH CHECK ]====================*/
function checkAuthenticate() {
    if (!isset($_SERVER['PHP_AUTH_USER']) || !isset($_SERVER['PHP_AUTH_PW'])) {
        printFailure("Unauthorized access");
    }
    if ($_SERVER['PHP_AUTH_USER'] != "wael" || $_SERVER['PHP_AUTH_PW'] != "wael12345") {
        printFailure("Invalid credentials");
    }
}

/*====================[ EMAIL & FCM ]====================*/
function sendEmail($to, $title, $body) {
    $header = "From: info@owael.com";
    mail($to, $title, $body, $header);
}





function sendGCM($title, $message, $topic, $pageid = "", $pagename = "") {
    $url = 'https://fcm.googleapis.com/fcm/send';
    $fields = [
        "to" => "/topics/$topic",
        'priority' => 'high',
        'notification' => [
            "body" => $message,
            "title" => $title,
            "click_action" => "FLUTTER_NOTIFICATION_CLICK",
            "sound" => "default"
        ],
        'data' => [
            "pageid" => $pageid,
            "pagename" => $pagename
        ]
    ];
    $headers = [
        'Authorization: key=' . "<<<ضع مفتاح السيرفر FCM هنا>>>",
        'Content-Type: application/json'
    ];
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));
    $result = curl_exec($ch);
    curl_close($ch);
    return $result;
}
