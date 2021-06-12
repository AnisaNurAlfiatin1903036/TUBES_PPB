<?php
include 'db.php';

$voter = $_POST['voter'];

$sql = "SELECT * FROM votes WHERE voters_id = '$voter' AND position_id = '1'";
$query = $conn->query($sql);

if ($query->num_rows > 0) {
    echo json_encode(['platform' => 'Anda Telah Melakukan Vote']);
}
