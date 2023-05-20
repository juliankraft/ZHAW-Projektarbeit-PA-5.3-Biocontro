# BIOCONTROL - MANAGEMENT VON SCHÄDLINGEN UND NÜTZLINGEN

ZÜRCHER HOCHSCHULE FÜR ANGEWANDTE WISSENSCHAFTEN <br>
DEPARTEMENT LIFE SCIENCES UND FACILITY MANAGEMENT <br>
Institut für Umwelt und natürliche Ressourcen

Praxisauftrag Grundlagen Biologische Landwirtschaft und Hortikultur 1

von: <br>
Chloé Diethelm, Lynda Forster, Julian Kraft, Katja Lange

Bachelorstudiengang 2022 <br>
Umweltingenieurwesen <br>
Abgabedatum 12. Juni 2023 <br>
Korrektorin: Esther Fischer
## Beschreibung
In diesem Repository werden die Rohdaten und der Code im Zusammenhang mit diesem Auftrag geteilt.
## Monitoring Tool
Das File monitoring_app.R zusammen mit dem Inhalt des Ordners resources ist der Code für das Tool, das wir für das Monitoring entwickelt haben. Es kann unter diesem [Link](https://rstudio.zhaw.ch/rsconnect/content/1b666be3-48a2-4c27-a834-e228f57dde0e) ausprobiert werden. In der Version, die wir tatsächlich verwendet haben wurden sämtliche Datenpunkte direkt in eine SQL Datenbank geschrieben. Diese wurde nach abgeschlossener Erhebung deaktiviert.
## Daten
Unter data sind alle Rohdaten abgelegt, die für diese Arbeit erhoben wurden. Eine Minimale Aufbereitung und Bereinigung hat bereits stattgefunden. Die Monitoring Daten wurden aus der SQL Datenbank exportiert und bereinigt. Die Loggerdaten wurden mittels converter_loggerdata.R in die hier verfügbare Form gebracht und zusammengefasst. 
## Datenauswertung
Das Jupyter Notebook auswertung.ipynb beinhaltet den Code für all die grafischen und statistischen Auswertungen die gemacht wurden.