<!DOCTYPE html>
<html>
<head>
    <title>Form Laporan</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <?php
    //Include file koneksi, untuk koneksikan ke database
    include "koneksi.php";

    //Fungsi untuk mencegah inputan karakter yang tidak sesuai
    function input($data) {
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }

    //membuat code laporan secara acak
    function generateRandomCode($length = 8) {
        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $code = '';

        for ($i = 0; $i < $length; $i++) {
            $code .= $characters[rand(0, strlen($characters) - 1)];
        }

        return $code;
    }

    //Cek apakah ada kiriman form dari method post
    if ($_SERVER["REQUEST_METHOD"] == "POST") {

        $code_laporan=input(generateRandomCode(8));
        $location=input($_POST["location"]);
        $description=input($_POST["description"]);
        $currentDate = date('Y-m-d');
        $user_id=input($_POST["user_id"]);


        //Query input menginput data kedalam tabel anggota
        $sql="insert into laporan (code_laporan, location, description, date, user_id) values
		('$code_laporan', '$location','$description','$currentDate', '$user_id')";

        //Mengeksekusi/menjalankan query diatas
        $hasil=mysqli_query($kon,$sql);

        //Kondisi apakah berhasil atau tidak dalam mengeksekusi query diatas
        if ($hasil) {
            header("Location:index.php");
        }
        else {
            echo "<div class='alert alert-danger'> Data Gagal disimpan.</div>";

        }

    }
    ?>
    <h2>Input Laporan</h2>

    <form action="<?php echo $_SERVER["PHP_SELF"];?>" method="post">
    <div class="form-group">
        <label>Pelapor:</label>
        <select name="user_id" class="form-control" required>
            <option value="" disabled selected>Pilih Pelapor</option>
            <?php
                // Ambil data laporan dari database 
                $sql = "SELECT id, name FROM user";
                $result = mysqli_query($kon,$sql);

                // Tampilkan data dalam dropdown
                while ($row = mysqli_fetch_assoc($result)) {
                    echo "<option value='" . $row['id'] . "'>" . $row['name'] . "</option>";
                }

                // Tutup koneksi dan hasil query
                mysqli_free_result($result);
            ?>
        </select>
    </div>
    <div class="form-group">
        <label>Location:</label>
        <input type="text" name="location" class="form-control" placeholder="Masukan Location" required/>
    </div>
    <div class="form-group">
        <label>Description:</label>
        <input type="text" name="description" class="form-control" placeholder="Masukan Description" required/>
    </div>
    <button type="submit" name="submit" class="btn btn-primary">Submit</button>
</form>

</div>
</body>
</html>