
![](./wpwn-removebg.png)
# WPwn
Ideal tool to automate WiFi attacks (WPA/WPA2 - PSK) aimed at obtaining the password.

The WPwn tool has 2 attack modes. The first one is the **Handshake attack**, where in an automated way, everything necessary is managed to obtain a valid Handshake by means of a classic de-authentication and reconnection attack by a station, with which we can later work to apply brute force.

The second attack mode is the **PKMID ClientLess Attack**, which focuses its attention on wireless networks that do not have associated clients (Modern Method).

## How can you run it?
The tool has 2 parameters, on the one hand the **'-a'** parameter to specify the attack mode (Handshake | PKMID) and on the other hand the **'-n'** parameter to specify the name of the network card.

However, the tool has a help panel after execution, and with the option **'-h'** this pannel can also be displayed:
```bash
┌─[root@parrot]─[/home/eur1p3des/WPwn]
└──╼ #./WPwn.sh 
[*] Using: ./WPwn.sh
        a) Attack mode
                Handshake
                PKMID
        n) Networkcard name
        h) Display help pannel
```


---
## Credits
This tool has been based on the [s4viPwnWifi tool](https://github.com/s4vitar/wifiCrack.git) created by S4vitar
