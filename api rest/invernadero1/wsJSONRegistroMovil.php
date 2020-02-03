<?PHP
$hostname_localhost="localhost";
$database_localhost="bdinvernadero";
$username_localhost="root";
$password_localhost="";

$conexion=mysqli_connect($hostname_localhost,$username_localhost,$password_localhost,$database_localhost);

	$id = $_POST["idplanta"];
	$nombre = $_POST["nombreplanta"];
	$nombreC = $_POST["nombrecientificoplanta"];
	$fecha = $_POST["fechasiembraplanta"];
	$altura = $_POST["aturamaxplanta"];
	$imagen = $_POST["fotoplanta"];

	$path = "imagenes/$nombre.jpg";

	//$url = "http://$hostname_localhost/ejemploBDRemota/$path";
	$url = "imagenes/".$nombre.".jpg";

	file_put_contents($path,base64_decode($imagen));
	$bytesArchivo=file_get_contents($path);

	$sql="INSERT INTO planta VALUES (?,?,?,?,?,?)";
	$stm=$conexion->prepare($sql);
	$stm->bind_param('isssss',$id,$nombre,$nombreC,$fecha,$altura,$bytesArchivo);
		
	if($stm->execute()){
		echo "registra";
	}else{
		echo "noRegistra";
	}
	
	mysqli_close($conexion);
?>

