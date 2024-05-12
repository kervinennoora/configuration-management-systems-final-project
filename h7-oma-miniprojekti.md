# h7 - Oma miniprojekti
### Noora Kervinen, 2024

Miniprojektini tavoitteena on luoda Linux virtuaalikoneympäristö herra-orja-arkkitehtuurilla. Luoda masterkoneella skripti, joka asentaa orjalle Cowsayn. Tämän jälkeen luoda toinen skripti, joka asettaa Cowsay ilmoituksen orjakoneen MOTD-osioon, jossa kerrotaan kellonaika ja päivämäärä. *MOTD* eli Message of The Day on ensimmäinen asia, jonka käyttäjä näkee kirjautuessaan koneelle. Projekti on julkaistu GNU General Public License, versio 3 oikeuksien alla.

## Virtuaalikoneympäristön luonti

Hyödynnän Vagranttia virtuaalikoneympäristön luomiseksi. Tätä varten menen koneessani sijaintiin ```D:/lopputyo/```, jonne luon tiedoston nimeltään *Vagrantfile* komennolla ```notepad Vagrantfile```. Tämä tiedosto on Vagrantin konfiguraatiotiedosto, joka sisältää tietoja luotavista virtuaalikoneista. Tiedostossa määritetään mm. virtuaalikoneen nimi ja IP-osoite. Käyttämäni Vagrantfilen löytää reposition kansiosta *Additional-material*. 

Vagrantfile sisälsi seuraavat tiedot:

![lopputyo2 1](https://github.com/kervinennoora/configuration-management-systems-final-project/assets/165003747/b0817f4e-9855-4c92-b538-821b3bf46407)

Tiedoston tallennuksen jälkeen on tärkeä tarkistaa onhan konfiguraatio tiedosto varmasti oikeassa muodossa. Joskus tiedostot tallentuvat .txt-muotoon, jonka takia ne eivät toimi toivotulla tavalla. Tämän tapahtuessa komentoa ```mv Vagrantfile.txt Vagrantfile``` käyttämällä, voi muuttaa tiedoston oikeaan muotoon. Tämän jälkeen komentoa ```Vagrant up``` käyttämällä syntyy uusivirtuaalikoneympätistö kahdella koneella!

Virtuaaliympäristön latauduttua otin SSH-yhteyden molempiin virtuaalikoneisiin ja syötin niihin komennot ```sudo apt-get update``` ja ```sudo apt-get upgrade```.

![lopputyo3](https://github.com/kervinennoora/configuration-management-systems-final-project/assets/165003747/0ec44ef6-b7ac-4df2-8ce3-3119d7c2d296)
![lopputyo3 2](https://github.com/kervinennoora/configuration-management-systems-final-project/assets/165003747/14f6d576-85d4-4d12-b826-734d56025bdc)

## Herra-orja-arkkitehtuuri

Tässä projektissa virtuaalikone *Gru* toimi master-koneena ja *Kevin* orja-koneena. On aika luoda herra-orja-arkkitehtuuri. Aloitin työstämisen master-koneesta jonne syötin komennon ```sudo apt-get -y install salt-master```. Tämä komento asentaa koneelle Salt-masterin.

![lopputyo4](https://github.com/kervinennoora/configuration-management-systems-final-project/assets/165003747/334b9e85-4794-4f70-8135-1d0ea7292a77)

Tämän jälkeen ajoin komennon ```hostname -I```, joka kertoo virtuaalikoneen IP-osoitteen. Tämä on tärkeä tieto arkkitehtuuria rakentaessa.

![lopputyo4 2](https://github.com/kervinennoora/configuration-management-systems-final-project/assets/165003747/9f2add62-9643-4075-be4d-87bfd78776aa)

Tämän jälkeen siirryin virtuaalikoneelle *Kevin* ja aloin työstämään siitä orja-konetta. Aloitin ajamalla komennon ```sudo apt-get -y install salt-minion```. Komento asentaa virtuaalikoneelle Salt-minionin. Tämän jälkeen ajoin komennon ```sudoedit /etc/salt/minion/```. Tämä on tiedosto, jonne voimme laittaa master-koneen IP-osoitteen, jotta koneet kommunikoivat keskenään. Tämän lisäksi voimme antaa nimen, jolla master-kone tunnistaa orjan. 

Lisäsin tiedostoon nämä tiedot:

![lopputyo5 2](https://github.com/kervinennoora/configuration-management-systems-final-project/assets/165003747/bfd9418a-e52f-465f-9a9b-0881b1c3ccc7)

Tämän jälkeen uudelleen käynnistin orja-koneen komennolla ```sudo systemctl restart salt-minion.service``` ja siirryin takaisin master-koneeni pariin. Master-koneella *gru* ajoin komennon ```sudo salt-key -A```. Komento etsii hyväksymättömät orjakoneet. Komennon ajettua selvisi, että kone *Kevin* tahtoo ottaa yhteyttä, joten hyväksyin avaimen masterkoneellani. 

![lopputyo6 2](https://github.com/kervinennoora/configuration-management-systems-final-project/assets/165003747/c8fda7b6-5906-4399-a05c-646c16091636)

Lopuksi ajoin simppelin komennon ```sudo salt '*' cmd.run 'whoami'```, testatakseni yhteyttä master- ja orja-koneen välillä. 

![lopputyo6 3](https://github.com/kervinennoora/configuration-management-systems-final-project/assets/165003747/c1d4e34b-8cac-435e-88a9-c179a2d8a9e6)

## Cowsayn asennus orja-koneelle masterilta käsin

Nyt kun projektin ympäristön luonti on valmista, on aika siirtyä projektin hauskaan osuuteen! Tämä osuus painottuu master-koneeseen, mutta lopputuloksena on onnistunut asennus orja-koneella. Aloitin osuuden luomalla hakemiston ```/usr/local/bin``` käyttämällä komentoa ```sudo mkdir /usr/local/bin```. Tämän jälkeen siirryin haluttuun hakemistoon komennolla ```cd /usr/local/bin```. Päästyäni oikeaan hakemistoon loin skripti-tiedoston asennus.sh käyttäen komentoa ```sudoedit asennus.sh```. Käyttämäni skriptitiedoston löytää reposition kansiosta *Additional-material*. 

Skriptitiedosto *asennus.sh* näytti seuraavanlaiselta:

![lopputyo7](https://github.com/kervinennoora/configuration-management-systems-final-project/assets/165003747/ff164bf4-09f2-444b-8673-67548fcd6bcf)

Tämän jälkeen muutin skriptitiedoston oikeuksia komennolla ```sudo chmod +x asennus.sh```. Tämän jälkeen palasin masterkoneen kotihakemkistoon ja loin uuden hakemiston ```/srv/salt/asennus``` käyttäen komentoa ```sudo mkdir /srv/salt/asennus```. Siittyin uuteen hakemistooni, jonne kopioin skriptitiedostoni *asennus.sh* hyödyntäen komentoa ```sudo cp /urs/local/bin/asennus.sh /srv/salt/asennus```. Komentoa ```ls``` käyttäen tarkistin, onnistuiko tiedoston kopiointi haluttuun hakemistoon. Omaksi onnekseni kaikki oli mennyt hyvin ja kopiointi onnistui!

![lopputyo7 3](https://github.com/kervinennoora/configuration-management-systems-final-project/assets/165003747/caa63cac-a750-4b63-9fc9-e54ae858e3e7)

Tämän jälkeen kopion skripti-tiedoston sisällön ja siirsin ne tiedostoon *asennus*. Tämän tein käyttäen komentoa ```sudoedit asennus``` ja copy-pastetin *asennus.sh* -tiedoston sisällön sinne. Tämän jälkeen tallensin tiedoston ja vielä *init.sls* -tiedoston samaan kansioon hyödyntäen komentoa ```sudoedit init.sls``` . *Init.sls* -tiedoston sisällön löytää myös reposition kansiosta *Additional-material*. 

*Init.sls* -tiedoston sisältö näytti seuraavanlaiselta:

![lopputyo7 5](https://github.com/kervinennoora/configuration-management-systems-final-project/assets/165003747/87a6038b-6c05-42d0-be4c-8dab47d0ce66)

Tämän jälkeen oli aika testata skriptintoimivuutta. Olin jännän äärellä kun ajoin komennon ```sudo salt salt '*' state.apply asennus```. Onneksi kaikki menikin hyvin ja kaikki tarvittavat tiedostot skirptin ajamista varten olivat asentuneet orja-koneella. Ajoin komennon kahdesti saavuttaakseni idempotentin tilan. 

![lopputyo8](https://github.com/kervinennoora/configuration-management-systems-final-project/assets/165003747/cf245622-153c-42db-a9a8-b8a34374e74b)

Tämän jälkeen oli aika ajaa skripti. Tämäkin jännitti. Ajoin komennon ```sudo salt '*' cmd.run asennus```. Iloksi ja onnekseni tämänkin komennon ajaminen onnistui! Tämä siis tarkoittaa, että orja-koneellani *Kevin* on nyt onnistuneesti asennettu Cowsay. Mutta on ainoastaan yksi tapa varmistaa tämä, testata toimiiko sovellus orja-koneella. Siirryin siis orja-koneelleni ja ajoin komennon ```cowsay muu```, jos näytölle tulostuu kuva lehmästä, skriptini onnistui. Olin iloinen huomatessani, että kaikki oli mennyt nappiin ja olen taas askeleen lähempänä projektini tavoitetta.

![lopputyo8 2](https://github.com/kervinennoora/configuration-management-systems-final-project/assets/165003747/08235bf8-7ca0-44c9-a214-f01eec045c95)

## Viesti MOTD-osioon

Aloitin tämän osuuden projektista palaamalla takaisin kansioon ```/usr/local/bin/``` ja loin sinne uuden skriptitiedoston *motd.sh* Tämä skriptitiedosto sisältää määritelmät parametreille *aika* ja *paiva*. Nämä määrittävät viestin sisällön tärkeimmän osuuden, sillä se sisältää informaation. Tämän lisäksi skripti sisältää viestin, joka kerrotaan käyttäjälle tämän kirjautuessa koneelle. Lisäksi skripti generoi cowsay viestin sijaintiin ```tmp/motd.tmp```. Lopuksi skripti tallentaa viestin motd-tiedostoon. Skriptitiedoston *motd.sh* löytää reposition kansiosta *Additional-material*. 

Skriptitiedosto *motd.sh* näytti tältä:

![lopputyo9](https://github.com/kervinennoora/configuration-management-systems-final-project/assets/165003747/aee90a15-f9ea-4256-931b-1305980f621f)

## References

Karvinen, T. 2024. h7 - oma miniprojekti. https://terokarvinen.com/2024/configuration-management-2024-spring/#h7-oma-miniprojekti

Karvinen, T. 2024. Infra as Code - Palvelinten hallinta. https://terokarvinen.com/2024/configuration-management-2024-spring/

Vivek, G. 2024. How To Format Date For Display or Use In a Shell Script. https://www.cyberciti.biz/faq/linux-unix-formatting-dates-for-display/

Vivek, G. 2017. Run crontab (cron jobs) Evety 10 Minutes. https://www.cyberciti.biz/faq/crontab-every-10-min/

Kervinen, N. 2024. h2 - Soitto kotiin. https://github.com/kervinennoora/configuration-management-systems/blob/main/h2-soitto-kotiin.md

Kervinen, N. 2024. h5 - Tekniikoita. https://github.com/kervinennoora/configuration-management-systems/blob/main/h5-tekniikoita.md
