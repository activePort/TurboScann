#!/bin/bash

# Leer la IP proporcionada como argumento
IP=$1

# Verificar si se proporcionó una IP
if [ -z "$IP" ]; then
    echo "Por favor, proporciona una IP como argumento."
    exit 1
fi

# Ejecutar el primer comando nmap para encontrar puertos abiertos
echo "Ejecutando el primer comando nmap..."
nmap_result=$(nmap -p- --open -sS --min-rate 5000 $IP -Pn)

# Extraer los números de puerto abierto y guardarlos separados por comas
open_ports=$(echo "$nmap_result" | grep -oP '\d+/tcp\s+open' | grep -oP '\d+' | paste -sd "," -)

# Mostrar los números de puerto abiertos
echo "Puertos abiertos: $open_ports"

# Ejecutar el segundo comando nmap utilizando los puertos reportados anteriormente
echo "Ejecutando el segundo comando nmap..."
nmap_second_result=$(nmap -sC -sV -p$open_ports $IP -Pn)

# Generar el resultado en formato HTML
html_output="<pre>$nmap_second_result</pre>"
html_content="<img src='./ts2.png' alt='logo' width='400' style='display: block;margin-left: auto;margin-right: auto;width: 20%;'/><br><h1 style='text-align:center;'>Reporte de TurboScann</h1><div style='display: block;margin-left: auto;width: 80%;'><pre>$nmap_second_result</pre></div>"

# Guardar el resultado en un archivo HTML
echo "$html_content" > scan_result.html

# Generar un archivo CSS para el estilo de la salida HTML
css_file="scan_result.css"
echo "pre { font-family: monospace; white-space: pre-wrap; }" > "$css_file"

# Agregar referencia al archivo CSS en el archivo HTML
sed -i "2i <link rel='stylesheet' type='text/css' href='$css_file'>" scan_result.html

# Abrir el archivo HTML en un navegador web
echo "Mostrando el resultado en el navegador..."
firefox scan_result.html
