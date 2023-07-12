<p align="center">
<img src='/ts2.png' alt='logo' width='300'/>
</p>
  
<h1 align="center">🚀 TurboScann v1</h1>

<p>TurboScann is a simple bash script that streamlines the port scanning process with nmap.</p>

<p>The first thing it does is to see which ports are open on the target with the -sS flag, a minimum rate of packets per second to be sent during the scan of 5000 and -Pn to perform the scan without sending a host discovery ping.</p>

```shell
  nmap_result=$(nmap -p- --open -sS --min-rate 5000 $IP -Pn)
```

After getting the list of ports that are open, it performs another scan to determine the service and version running on those ports.

```shell
  nmap_second_result=$(nmap -sC -sV -p$open_ports $IP -Pn)
```

<p>After the last scan is done, the browser opens with the final result in html.</p>

<p align="center">
<img src='/Captura de pantalla 2023-07-11 a la(s) 21.54.59.png' alt='example' width='100%'/>
</p>

<h2>Pre-requisites</h2>
<p>Have installed nmap</p>

<h2>Installation</h2>

```shell
  ~$ git clone https://github.com/activePort/TurboScann.git
  ~$ cd TurboScann
  ~$ chmod +x ./turboscann.sh
  ~$ sudo ./turboscann.sh 10.10.10.40
```
<h2>⚠️ Warning ⚠️</h2>
<p>It was only tested in Kali. On other systems I don't know how it will work.</p>
