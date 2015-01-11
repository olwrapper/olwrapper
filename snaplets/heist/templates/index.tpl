<!DOCTYPE html>

<!-- minimum code
<html>
	<head>
		<script src="http://openlayers.org/en/v3.1.1/build/ol.js"/>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"/>
		<script src="/fay/Index.js"/>
	</head>
	<body>Hello Map
		<div id="map"/>
	</body>
</html>
-->


<!-- tutorial -->
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<title>Haskell OpenLayers Wrapper - diploma thesis TU Vienna 2015 - Geoinformation</title>
		<script src="http://openlayers.org/en/v3.1.1/build/ol.js"/>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"/>
		<script src="/fay/Index.js"/>
		<style type="text/css">
			* {
				font-family: Arial, Verdana, Helvetica, sans-serif;
			}
			#map {
				width: 500px;
				height: 300px;
			}
		</style>
	</head>
	<body>
		<center>
			<p><b>Haskell OpenLayers Wrapper</b></p>
			
			<div id="mapdesc"></div>
			
			<table style="padding: 12px;">
				<tr>
					<td id="table1" style="color: red;    padding-right: 12px"/>
					<td id="table2" style="color: purple; padding-right: 12px"/>
					<td id="table3" style="color: orange; padding-right: 12px"/>
					<td id="table4" style="color: green"/>
				</tr>
			</table>
			
			<div id="map"></div>
			
			<table style="padding: 12px;">
				<tr>
					<td>Zoomlevel:</td>
					<td>
						<div id="zoomlabel"     align="center" style="padding: 4px"></div>
					</td>
				</tr>
				<tr>
					<td>Kartenzentrum (WGS 84):</td>
					<td>
						<div id="wgslabel"      align="center" style="padding: 4px"></div>
					</td>
				</tr>
				<tr>
					<td>Kartenzentrum (Mercator):</td>
					<td>
						<div id="mercatorlabel" align="center" style="padding: 4px"></div>
					</td>
				</tr>
			</table>
		</center>
	</body>
</html>
