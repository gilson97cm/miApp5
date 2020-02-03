<?PHP
$hostname_localhost ="localhost";
$database_localhost ="bdinvernadero";
$username_localhost ="root";
$password_localhost ="";

$json=array();

	if(isset($_GET["idinvernadero"])){
		$id=$_GET["idinvernadero"];
				
		$conexion = mysqli_connect($hostname_localhost,$username_localhost,$password_localhost,$database_localhost);

		$consulta="SELECT * from invernadero where idinvernadero= '{$id}'";
		$resultado=mysqli_query($conexion,$consulta);
			
		if($registro=mysqli_fetch_array($resultado)){
			$json['invernadero'][]=$registro;
		//	echo $registro['id'].' - '.$registro['nombre'].' - '.$registro['profesion'].'<br/>';
		}else{
			$resultar["idinvernadero"]=0;
			$resultar["ubicacioninvernadero"]='no registra';
			$resultar["tamanoinvernadero"]='no registra';
			$resultar["alturainvernadero"]='no registra';
			$resultar["anchoinvernadero"]='no registra';
			$resultar["largoinvernadero"]='no registra';
			$resultar["materialinvernadero"]='no registra';
			$json['invernadero'][]=$resultar;
		}
		
		mysqli_close($conexion);
		echo json_encode($json);
	}
	else{
		$resultar["success"]=0;
		$resultar["message"]='Ws no Retorna';
		$json['invernaderos'][]=$resultar;
		echo json_encode($json);
	}
?>