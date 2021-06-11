
<?php
include 'db.php';

$sql = "SELECT votes.*, candidates.id, candidates.firstname, candidates.lastname, COUNT(*) FROM votes INNER JOIN candidates ON votes.candidate_id = candidates.id where votes.position_id = 2 GROUP BY votes.candidate_id
";

$result = array();

$query = $conn->query($sql);


while ($row = $query->fetch_assoc()) {
    $result[] = $row;
}
if ($query->num_rows > 0) {
    echo json_encode(['data' => $result]);
} else {
    echo json_encode(['error' => 'Kata Sandi Salah!!']);
}
