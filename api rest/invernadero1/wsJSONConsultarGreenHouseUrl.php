<?PHP
$hostname_localhost ="localhost";
$database_localhost ="invernadero";
$username_localhost ="root";
$password_localhost ="";

$json=array();

	if(isset($_GET["idinvernadero"])){
		$ideinvernadero=$_GET["idinvernadero"];
				
		$conexion = mysqli_connect($hostname_localhost,$username_localhost,$password_localhost,$database_localhost);

		//$consulta="select * from usuario where documento= '{$documento}'";
        $consulta = "SELECT invernadero.idinvernadero, invernadero.ubicacioninvernadero, invernadero.tamanoinvernadero, 
                            invernadero.alturainvernadero, invernadero.anchoinvernadero, invernadero.largoinvernadero, 
                            invernadero.materialinvernadero, planta.idplanta, planta.nombreplanta, planta.nombrecientificoplanta,
                            planta.fechasiembraplanta, planta.aturamaxplanta FROM invernadero, cultivo, estado, planta  
                            WHERE invernadero.idinvernadero = '{$ideinvernadero}' AND invernadero.idinvernadero = cultivo.invernadero_idinvernadero 
                            AND cultivo.estado_idestado = estado.idestado AND estado.planta_idplanta = planta.idplanta";
		$resultado=mysqli_query($conexion,$consulta);
			
		if($registro=mysqli_fetch_array($resultado)){
			$result["idinvernadero"]=$registro['idinvernadero'];
			$result["ubicacioninvernadero"]=$registro['ubicacioninvernadero'];
			$result["tamanoinvernadero"]=$registro['tamanoinvernadero'];
			$result["alturainvernadero"]=$registro['alturainvernadero'];
			$result["anchoinvernadero"]=$registro['anchoinvernadero'];
			$result["largoinvernadero"]=$registro['largoinvernadero'];
			$result["materialinvernadero"]=$registro['materialinvernadero'];
			//planta
			$result["idplanta"]=$registro['idplanta'];
			$result["nombreplanta"]=$registro['nombreplanta'];
			$result["nombrecientificoplanta"]=$registro['nombrecientificoplanta'];
			$result["fechasiembraplanta"]=$registro['fechasiembraplanta'];
			$result["aturamaxplanta"]=$registro['aturamaxplanta'];
			$json['invernaderoplanta'][]=$result;
		}else{
			$resultar["idinvernadero"]=0;
			$resultar["ubicacioninvernadero"]='no registra';
			$resultar["tamanoinvernadero"]='no registra';
			$result["alturainvernadero"]='no registra';
			$result["anchoinvernadero"]='no registra';
			$result["largoinvernadero"]='no registra';
			$result["materialinvernadero"]='no registra';
			//planta
			$result["idplanta"]='no registra';
			$result["nombreplanta"]='no registra';
			$result["nombrecientificoplanta"]='no registra';
			$result["fechasiembraplanta"]='no registra';
			$result["aturamaxplanta"]='no registra';
			$json['invernaderoplanta'][]=$resultar;
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