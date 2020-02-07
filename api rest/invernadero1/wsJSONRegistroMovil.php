<?PHP
$hostname_localhost="localhost";
$database_localhost="invernadero";
$username_localhost="root";
$password_localhost="";

$conexion=mysqli_connect($hostname_localhost,$username_localhost,$password_localhost,$database_localhost);

	/*$id = $_POST["idplanta"];
	$nombre = $_POST["nombreplanta"];
	$nombreC = $_POST["nombrecientificoplanta"];
	$fecha = $_POST["fechasiembraplanta"];
	$altura = $_POST["aturamaxplanta"];*/
	//$id = $_POST["id_mercado"];
	$tipo = $_POST["tipo_mercado"];
	$nombre = $_POST["nombrerosa_mercado"];
	$nombreC = $_POST["nombrecientifico_mercado"];
	$tamano = $_POST["tamanoboton_mercado"];
	$imagen = $_POST["fotoplanta_mercado"];

	


	$valid = "SELECT * FROM mercado WHERE tipo_mercado = '$tipo'";
	$r = $conexion->prepare($valid);
	$result = mysqli_query($conexion,$valid);
	if(mysqli_num_rows($result) > 0){
		echo "isRepeat";
	}else{
		$path = "imagenes/$nombre.jpg";

	//$url = "http://$hostname_localhost/ejemploBDRemota/$path";
	$url = "imagenes/".$nombre.".jpg";

	file_put_contents($path,base64_decode($imagen));
	$bytesArchivo=file_get_contents($path);

	$sql="INSERT INTO mercado (tipo_mercado,nombrerosa_mercado,nombrecientifico_mercado,tamanoboton_mercado,fotoplanta_mercado,rutafoto_mercado) VALUES (?,?,?,?,?,?)";
	$stm=$conexion->prepare($sql);
	$stm->bind_param('ssssss',$tipo,$nombre,$nombreC,$tamano,$bytesArchivo,$url);
		
	if($stm->execute()){
		echo "registra";
	}else{
		echo "noRegistra";
	}
	}
	
	mysqli_close($conexion);
?>

