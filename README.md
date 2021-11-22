<h1 id="wpwn">WPwn</h1>

<p align="center"><img src="img/logo.png" alt="" width='50%' /></p>

<p>Ideal tool to automate WiFi attacks (WPA/WPA2 - PSK) aimed at obtaining the password.</p>

<p>The WPwn tool has 2 attack modes. The first one is the <strong>Handshake attack</strong>, where in an automated way, everything necessary is managed to obtain a valid Handshake by means of a classic de-authentication and reconnection attack by a station, with which we can later work to apply brute force.</p>

<p>The second attack mode is the <strong>PKMID ClientLess Attack</strong>, which focuses its attention on wireless networks that do not have associated clients (Modern Method).</p>

<h2 id="howcanyourunit">How can you run it?</h2>

<p>The tool has 2 parameters, on the one hand the <strong>'-a'</strong> parameter to specify the attack mode (Handshake | PKMID) and on the other hand the <strong>'-n'</strong> parameter to specify the name of the network card.</p>

<p>However, the tool has a help panel after execution, and with the option <strong>'-h'</strong> this pannel can also be displayed:</p>

<pre><code class="bash language-bash">
root @ thc in /home/eur1p3des/Wifi_Cracker on git:main o [12:42:45] 
$ ./wpwn.sh              

█     █░ ██▓███   █     █░███▄    █
▓█░ █ ░█░▓██░  ██▒▓█░ █ ░█░██ ▀█   █
▒█░ █ ░█ ▓██░ ██▓▒▒█░ █ ░█▓██  ▀█ ██▒
░█░ █ ░█ ▒██▄█▓▒ ▒░█░ █ ░█▓██▒  ▐▌██▒
░░██▒██▓ ▒██▒ ░  ░░░██▒██▓▒██░   ▓██░
░ ▓░▒ ▒  ▒▓▒░ ░  ░░ ▓░▒ ▒ ░ ▒░   ▒ ▒ 
  ▒ ░ ░  ░▒ ░       ▒ ░ ░ ░ ░░   ░ ▒░
  ░   ░  ░░         ░   ░    ░   ░ ░ 
    ░                 ░            ░ 

Made by (Eur1p3des)


[*] Using: ./wifi.sh
    a) Attack mode
        Handshake
        PKMID
    b) Networkcard name
    h) Show help pannel
</code></pre>

<hr />

<h2 id="credits">Credits</h2>

<p>This tool has been based on the <a href="https://github.com/s4vitar/wifiCrack.git">s4viPwnWifi tool</a> created by S4vitar</p>
