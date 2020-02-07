<?PHP
$hostname_localhost ="localhost";
$database_localhost ="invernadero";
$username_localhost ="root";
$password_localhost ="";

$json=array();

	if(isset($_GET["idplanta"])){
		$idplanta=$_GET["idplanta"];
				
		$conexion = mysqli_connect($hostname_localhost,$username_localhost,$password_localhost,$database_localhost);

		$consulta="select * from planta where idplanta= '{$idplanta}'";
		$resultado=mysqli_query($conexion,$consulta);
			
		if($registro=mysqli_fetch_array($resultado)){
			$result["idplanta"]=$registro['idplanta'];
			$result["nombreplanta"]=$registro['nombreplanta'];
			$result["nombrecientificoplanta"]=$registro['nombrecientificoplanta'];
			$result["fechasiembraplanta"]=$registro['fechasiembraplanta'];
			$result["aturamaxplanta"]=$registro['aturamaxplanta'];
			$result["fotoplanta"]=base64_encode($registro['fotoplanta']);
			$json['invernadero'][]=$result;
		}else{
			$resultar["idplanta"]=0;
			$resultar["nombreplanta"]='no registra';
			$resultar["nombrecientificoplanta"]='no registra';
			$resultar["fechasiembraplanta"]='no registra';
			$resultar["aturamaxplanta"]='no registra';
			$resultar["fotoplanta"]='no registra';
			$json['invernadero'][]=$resultar;
		}
		
		mysqli_close($conexion);
		echo json_encode($json);
	}
	else{
		$resultar["success"]=0;
		$resultar["message"]='Ws no Retorna';
		$json['usuario'][]=$resultar;
		echo json_encode($json);
	}
?>