<?php
include 'db.php';

$voter = $_POST['voter'];
$password = $_POST['password'];

$sql = "SELECT * FROM voters WHERE voters_id = '$voter'";
$query = $conn->query($sql);

if ($query->num_rows < 1) {
    echo json_encode(['error' => 'ID akun voter salah']);
} else {
    $row = $query->fetch_assoc();
    if (password_verify($password, $row['password'])) {
        echo json_encode($row);
    } else {
        echo json_encode(['error' => 'Kata Sandi Salah!!']);
    }
}
