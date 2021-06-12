<?php
include 'db.php';

$id_voter = $_POST['id_voter'];
$id_calon = $_POST['id_calon'];

$query = $conn->query("INSERT INTO votes (voters_id, candidate_id, position_id) VALUES ('" . $id_voter . "', '$id_calon', '1')");
