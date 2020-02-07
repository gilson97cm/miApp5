<?PHP
$hostname_localhost ="localhost";
$database_localhost ="invernadero";
$username_localhost ="root";
$password_localhost ="";

$json['fotoplanta']=array();

	//if(true){)
	if(isset($_POST["btn"])){
		
		$conexion = mysqli_connect($hostname_localhost,$username_localhost,$password_localhost,$database_localhost);
		
		$ruta="imagenes";
		$archivo=$_FILES['fotoplanta']['tmp_name'];
		echo 'Archivo';
		echo '<br>';
		echo $archivo;
		$nombreArchivo=$_FILES['fotoplanta']['name'];
		echo 'Nombre Archivo';
		echo '<br>';
		echo $nombreArchivo;
		move_uploaded_file($archivo,$ruta."/".$nombreArchivo);
		$ruta=$ruta."/".$nombreArchivo;
		$id=$_POST['idplanta'];
		$nombre=$_POST['nombreplanta'];
		$nombrecien=$_POST['nombrecientificoplanta'];
		$fecha=$_POST['fechasiembraplanta'];
		$aturamax=$_POST['aturamaxplanta'];

		
		echo '<br>';
		echo 'Id: ';
		echo $id;
		echo '<br>';
		echo 'Nombre: ';
		echo $nombre;
		echo '<br>';
		echo 'Nombre Cien: ';
		echo $nombrecien;
		echo '<br>';
		echo 'fecha :';
		echo $fecha;
		echo '<br>';
        echo 'AturaMax :';
        echo $aturamax;
        echo '<br>';
		echo 'Tipo Imagen: ';
		echo ($_FILES['fotoplanta']['type']);
		echo '<br>';
		echo '<br>';
		echo "Imagen: <br><img src='$ruta' width = 30 height=30>";
		echo '<br>';
		echo '<br>';
		echo 'imagen en Bytes: ';
		echo '<br>';
		echo '<br>';
		//echo $bytesArchivo=file_get_contents($ruta);
		echo '<br>';
		
		$bytesArchivo=file_get_contents($ruta);
		$sql="INSERT INTO planta(idplanta,nombreplanta,nombrecientificoplanta,fechasiembraplanta,aturamaxplanta,fotoplanta) VALUES (?,?,?,?,?,?)";
		$stm=$conexion->prepare($sql);
		$stm->bind_param('isssss',$id,$nombre,$nombrecien,$fecha,$aturamax,$bytesArchivo);
		
		if($stm->execute()){
			echo 'imagen Insertada Exitosamente ';
			$consulta="SELECT * from planta where idplanta='{$id}'";
			$resultado=mysqli_query($conexion,$consulta);
			echo '<br>';
			while ($row=mysqli_fetch_array($resultado)){
				echo $row['idplanta'].' - '.$row['nombreplanta'].'<br/>';
				array_push($json['fotoplanta'],array(
				    'idplanta'=>$row['idplanta'],
                    'nombreplanta'=>$row['nombreplanta'],
                    'nombrecientificoplanta'=>$row['nombrecientificoplanta'],
                    'fechasiembraplanta'=>$row['fechasiembraplanta'],
                    'aturamaxplanta'=>$row['aturamaxplanta'],
                    'fotoplanta'=>base64_encode($row['nombreplanta']),
                //    'ruta'=>$row['ruta_imagen']
                ));
			}
			mysqli_close($conexion);
			
			echo '<br>';
			echo 'Objeto JSON 2';
			echo '<br>';
			echo json_encode($json);
		}
	}
?>