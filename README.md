<br>

![markdown](https://img.shields.io/badge/Markdown-Tutorial-E34F26.svg?style=flat-square&logo=markdown&logoColor=E34F26)
![created](https://img.shields.io/badge/Erstellt-21.12.2022-E535AB.svg?style=flat-square&logo=quip&logoColor=E535AB)
![updated](https://img.shields.io/badge/Aktualisiert-21.12.2022-3C873A.svg?style=flat-square&logo=quip&logoColor=3C873A)<br>
![level](https://img.shields.io/badge/Level-B1%20aufwärts-F0DB4F.svg?style=flat-square&logo=swarm&logoColor=F0DB4F)
![autoit](https://img.shields.io/badge/Sprache-AutoIt-61DBFB.svg?style=flat-square&logo=autodesk&logoColor=61DBFB)<br>
![windows](https://img.shields.io/badge/OS-Windows-6569B0.svg?style=flat-square&logo=windows&logoColor=6569B0)

<br>

<h1 align="center">AutoIt Tutorial: WebDriver</h1>
<h3 align="center">Dein Einstieg in das "au3WebDriver" Projekt</h3>

<br>

| [Einführung](#-einführung) | [Projektstruktur](#-projektstruktur) |

| [Au3WebDriver](#-au3webdriver) | [Abhängigkeiten](#-abhängigkeiten) | [Setup](#-setup) |

| [Selektoren](#-selektoren) | [Anwendungsbeispiele](#-anwendungsbeispiele) | [Ein Ausblick](#-ein-ausblick) |

<br>
<br>

## ➀ Einführung

### 🔊 Willkommen

<audio src="https://user-images.githubusercontent.com/29656921/208984828-c703c348-0b87-491e-8fb7-f6d069a285a5.mp4" controls="controls"></audio>

<br>

### 📑 An wen richtet sich dieses Tutorial

Wenn du dich bereits mit AutoIt wohl fühlst, doch noch keine Berührungspunkte mit dem WebDriver bzw. dem au3WebDriver Projekt hattest, bist du hier richtig. Vielleicht wolltest du schon mal mit dem WebDriver beginnen und warst dir unsicher wie du starten solltest, trotz Dokumentation, einfach zu komplex auf dem ersten Blick? Dann lass dich von diesem praxisnahen Tutorial unterstützen und lass uns gemeinsam die ersten Hürden aus dem Weg räumen.

Du bist dir noch immer unsicher? Dann frage dich einmal ob du in der Vergangenheit mit der `IE.au3` UDF gearbeitet hast; ob du in irgendeiner Art und Weise einen Browser bzw. Webseiten automatisieren wolltest/musstest; ob du den Seiten Quellcode oder Teile davon extrahieren wolltest um die Informationen später weiter zu verarbeiten; ob du bspw. mit `InetGet()` nicht das Ergebnis bekommen hast, welches du dir erhofft hast? Dann ist dieses Tutorial deine Zeit wert. Auch wenn du sehr wahrscheinlich nicht alle Antworten auf deine konkreten Anwendungsfälle bekommen wirst, eröffnet dir dieses Tutorial neue Möglichkeiten bzgl. dieser oder anderer Fragestellungen im Bereich WEB.

Falls hiervon nichts bisher auf dich zu trifft und du einfach nur interessiert bist um was es geht, dann auch dir viel Spaß.

An sich empfehle ich Anwendern mit **Level B1** aufwärts, dieses Tutorial. Die Level-Tabelle dient jedoch nur der Orientierung und stellt eine Einstufungshilfe dar, daher lass dich nicht verunsichern und traue dich einfach.

📊 Level-Tabelle (Kontext AutoIt)

| Level  | Bezeichnung                            | Beschreibung                                                                           |
| :---   | :---                                   | :---                                                                                   |
| A1     | Anfänger                               | Hat mit AutoIt und seinen Konzepten begonnen                                           |
| A2     | Anwender mit grundlegenden Kenntnissen | Hat erste Skripte (meist noch mit Unterstützung) geschrieben                           |
| **B1** | Fortgeschrittener Anwender             | Kann die meisten Problemstellungen selbstständig bewältigen                            |
| B2     | Erfahrener Anwender                    | Kann komplexere Programme entwickeln                                                   |
| C1     | Fachkundiger Anwender                  | Kann sein AutoIt Breitenwissen für diverse Bereiche einsetzen (backend, frontend, API) |
| C2     | Experte                                | Kann sein AutoIt Breitenwissen einsetzen und fundiert weiter geben (vermitteln)        |

<br>

### 📑 Was erwartet dich

Du wirst die folgenden Dinge in diesem Tutorial kennen lernen:

-

<br>

### 📑 Was solltest du danach wissen und können

Eos cupiditate totam optio architecto. Magni et voluptas fugit repudiandae eos eos. Magni officia fuga cupiditate magnam recusandae suscipit aut quo. Rerum sunt dolorum sunt ea ut dolores. Ea harum dolores quo ut. Placeat voluptatibus dolorem.

<br>

### 📑 Was ist WebDriver

Corrupti quasi laborum et cupiditate incidunt corrupti. Quis quaerat suscipit exercitationem. Velit debitis nemo aut quasi rerum quaerat. Incidunt veritatis enim autem quidem eveniet sint fugiat. Voluptatem ipsa soluta.

<br>

### 📑 Was ist das au3WebDriver Projekt

Ut quia beatae qui iusto quos voluptas natus perferendis. Doloribus placeat labore deleniti. Impedit animi qui.

<br>

### 📑 Referenzen für mehr Details

Qui et id nihil odit enim. Nobis est quo. Est assumenda dolorem cum impedit quam molestiae.

<br>

### 📑 Kurze Zusammenfassung

Quaerat cupiditate nulla nisi quod. Ut debitis est placeat dolor ipsa corrupti ut reprehenderit inventore. Consequuntur earum saepe rerum autem laborum. Neque sed voluptatem nihil est enim. Consectetur et assumenda adipisci quisquam veritatis cumque.

<br>

[· ⇑ ·](#-einführung)

<br>

## ➁ Projektstruktur

### 📑 Grundlegender Aufbau

Maxime temporibus sint autem rerum velit rerum ex. Consequatur quo perferendis consequatur inventore. Laboriosam esse assumenda aut architecto vel accusamus quia voluptas similique. Vero autem qui a. Impedit mollitia iure ut qui.

<br>

### 📑 Modularisierung

Optio quam officiis totam est ipsam. Quia vitae dicta. Beatae maiores soluta perferendis facere debitis velit reiciendis eum.

<br>

### 📑 Kurze Zusammenfassung

Sit placeat quos sed voluptate assumenda voluptate voluptas. Rerum aliquid laborum molestias et repellendus qui enim dolore similique. Et magni dolor sint.

<br>

[· ⇑ ·](#-projektstruktur)

<br>

## ➂ Au3WebDriver

### 📑 Das Projekt Repository

Accusamus laboriosam earum voluptate molestiae et reprehenderit. Qui doloremque labore laudantium magnam voluptas porro quam cumque dolores. Quis aut nobis consectetur velit quod nisi sed expedita.

<br>

### 📑 Funktionalität

Voluptas corporis aut. Consequatur quia alias consectetur recusandae reiciendis eos dolorum tempora. Similique rerum commodi commodi nulla eos non unde. Eius rerum ipsam repellat earum non sint qui ea qui. Nemo architecto tenetur necessitatibus.

<br>

### 📑 Kurze Zusammenfassung

Quod minima et explicabo laboriosam vel animi quasi occaecati voluptate. Qui natus natus repellendus magni sed dolor veniam. Eum laborum ab officia soluta libero enim officiis.

<br>

[· ⇑ ·](#-au3webdriver)

<br>

## ➃ Abhängigkeiten

### 📑 Json UDF

Excepturi deserunt cumque in. Nisi minus et totam ut cumque eos omnis. Natus eius aliquam aliquid. Odit enim accusamus beatae sunt ut velit. Eligendi ut maxime. Deserunt voluptates sint hic voluptatem velit.

<br>

### 📑 ChromeDriver und GeckoDriver

Veniam qui voluptas dolor non consectetur qui blanditiis nam. Veniam sed inventore fugit earum. Consequatur voluptatibus et molestias doloribus.

<br>

### 📑 WinHttp UDF

Et et error non. Quaerat aut voluptas officia officia quis. Aliquam aut tenetur aut deserunt similique quas iure. Reiciendis qui nostrum sint est eos assumenda occaecati. Illum nihil mollitia atque odio.

<br>

### 📑 Kurze Zusammenfassung

Quae tenetur ab et quo et sit illum similique deleniti. Impedit et saepe autem. Corporis nesciunt magnam omnis eaque. Facilis incidunt sint asperiores incidunt asperiores voluptatibus ad et quisquam. Ut rerum numquam numquam quo qui perspiciatis sapiente accusantium corporis.

<br>

[· ⇑ ·](#-abhängigkeiten)

<br>

## ➄ Setup

### 📑 Log level setzen

Quisquam labore molestias natus dolores porro tenetur. Et molestiae corrupti nam at optio et tempora dolores illum. Et saepe ut. Illo voluptatum voluptatem expedita rerum natus cupiditate. Illo doloremque architecto quia nihil. Eos odio culpa quae et laboriosam ea sint sequi illo.

<br>

### 📑 Driver Optionen setzen

Magni enim incidunt ut non exercitationem. Est est non vero error dolor sint eligendi magni voluptatem. Est iste consequatur nobis quisquam pariatur reiciendis perspiciatis quis officia. Qui recusandae consequatur quod. Neque labore doloribus quis et occaecati voluptas laborum. Eius consequuntur veniam.

<br>

### 📑 Driver Capabilities setzen

Quam quod id libero. Corrupti consequuntur tenetur aut vero laudantium doloribus incidunt. Et et sint omnis molestias nihil ut. Et ipsum earum quae labore ipsa aperiam facere harum.

<br>

### 📑 Start und Teardown

Ratione consequatur magnam distinctio sapiente vel tenetur. Aperiam sed saepe molestias. Et soluta quidem tenetur qui eum in accusantium. Adipisci qui sapiente.

<br>

### 📑 Kurze Zusammenfassung

Et nobis voluptas et sint soluta omnis dolores. Facilis suscipit tenetur temporibus consequatur neque nihil sint sunt maiores. Laborum nemo nihil aliquam qui commodi est. Animi molestias inventore. Nemo ullam aut dolorem totam ut minus tempora quia est. Maiores magnam tempora sit totam ex provident et ea.

<br>

[· ⇑ ·](#-setup)

<br>

## ➅ Selektoren

### 📑 Locator-Strategien

Qui odio recusandae corrupti aut itaque nihil non commodi odit. Nesciunt dolores distinctio. Provident repudiandae eos maxime dignissimos distinctio explicabo eos optio ullam. Ad nihil voluptas. Distinctio autem error ad animi qui. Architecto aperiam culpa voluptatem.

<br>

### 📑 Der XPath Selektor

Praesentium aut repudiandae deleniti quibusdam qui dicta. Et laboriosam animi quisquam ea officia est. Perferendis optio qui omnis quos ad quas similique velit ipsam. Est non expedita. Nisi eligendi nobis quaerat reiciendis.

<br>

### 📑 Browser DevTools

Qui repellendus reprehenderit. Molestias qui sunt dolor consectetur. Consequuntur eum molestias facilis magnam est quis ipsa fugiat.

<br>

### 📑 Kurze Zusammenfassung

Tenetur voluptatem officia eum voluptatum nulla dolores occaecati natus quo. Amet est ipsum quod pariatur quia ea qui culpa. Tempore accusantium rerum amet qui vel odit vitae tempora nisi. Ipsum voluptate nesciunt dolores. Est similique dolor.

<br>

[· ⇑ ·](#-selektoren)

<br>

## ➆ Anwendungsbeispiele

### 📑 Navigation

Soluta quaerat in inventore nam facilis nostrum. Sunt a voluptates esse neque. Sequi cum magnam beatae perspiciatis quia sunt. Aspernatur dolorem enim molestiae in veniam ullam accusamus.

<br>

### 📑 Elemente finden und klicken

Ipsa ut fuga culpa illo doloribus est eaque quo et. Porro dicta similique aliquid sunt laudantium qui quis quaerat. Quo possimus iure aut minus veniam eos. Sit et aut nesciunt numquam.

<br>

### 📑 Input Felder ausfüllen

Qui et ab impedit qui ipsam omnis numquam. Officiis doloribus id. Aliquid voluptatem facere consequuntur omnis corrupti ducimus atque. Ea qui eaque. Voluptates aut quidem commodi quibusdam sapiente quasi. Voluptatem tempora sed temporibus nam cumque totam ratione enim.

<br>

### 📑 Auf Elemente warten

Atque reprehenderit quidem rerum accusantium ullam neque incidunt illo animi. Ipsam doloremque voluptas tempora. Id velit nulla veniam. Ratione accusantium rerum eum. Voluptas doloribus sed dolorum nostrum.

<br>

### 📑 Mehrere Elemente finden

Deleniti omnis velit nihil deserunt ipsam sed eos et accusantium. Quod quam fuga et molestiae fugiat. Quibusdam in perspiciatis corrupti non praesentium aliquam quo id et.

<br>

### 📑 Browser headless laufen lassen

Maiores eveniet delectus eum harum et laudantium. Nihil rerum id natus laudantium dignissimos hic animi quae. Est esse consequatur officiis molestiae nulla. Aliquam at aut necessitatibus tenetur.

<br>

### 📑 Seiteninhalt exportiern

Quia ut inventore. Id veniam totam dolor quas. Est sunt perspiciatis.

<br>

### 📑 Kurze Zusammenfassung

Impedit est aperiam. Facilis temporibus molestiae perferendis unde a. Laudantium voluptas in rerum enim ab quia architecto dignissimos. Beatae amet enim similique soluta fugiat sed debitis aut.

<br>

[· ⇑ ·](#-anwendungsbeispiele)

<br>

## ➇ Ein Ausblick

### 📑 A

Incidunt at occaecati quod accusantium. Quia quos culpa atque explicabo in autem in. Harum earum nobis sunt eos incidunt non. Maxime voluptas earum deleniti illo adipisci. Autem ipsum consequuntur voluptatem et debitis ratione id incidunt.

<br>

### 📑 B

Dolorem repellat est soluta autem enim. Natus nemo et sint non dignissimos tempora ut. Natus qui iusto dignissimos ex recusandae distinctio aliquid ut illum. Nulla necessitatibus enim corporis et doloribus rerum.

<br>

### 📑 Kurze Zusammenfassung

Pariatur eos natus. Occaecati et suscipit veniam. Recusandae tempora et dolor dolorem. Quos totam deleniti fuga laboriosam. Dolores vel aliquam eveniet ut reprehenderit atque magnam consequuntur quaerat. Magni fugit ut ut corrupti quia est.

<br>

[· ⇑ ·](#-ein-ausblick)

<br>

[· Nach oben ·](#)
