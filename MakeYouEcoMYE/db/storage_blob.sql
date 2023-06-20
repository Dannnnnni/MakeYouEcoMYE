DROP DATABASE IF EXISTS MakeYouEco;
CREATE DATABASE MakeYouEco;
USE MakeYouEco;

DROP TABLE IF EXISTS Product;

CREATE TABLE Product (
  Id INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50) NOT NULL,
  Description VARCHAR(500),
  Price  DECIMAL(10,2) NOT NULL,
  Weight DECIMAL(10,2),
  Image MEDIUMBLOB,
  Quantity INT NOT NULL,
  IVA DECIMAL(4,2) NOT NULL DEFAULT 22
);

CREATE TABLE User (
   Id INT PRIMARY KEY AUTO_INCREMENT,
   Name VARCHAR(50) NOT NULL,
   Surname VARCHAR(50) NOT NULL,
   Email VARCHAR(50) NOT NULL,
   Password VARCHAR(50) NOT NULL,
   Date_Registration VARCHAR(50) NOT NULL,
   Telephone VARCHAR(20) NOT NULL,
   Administrator BOOLEAN NOT NULL DEFAULT 0
);

CREATE TABLE Payment (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    CardNumber INT,
    CVV INT,
    -- Expiry DATE
	ExpiryMonth INT,
    ExpiryYear INT,
    
    User_Id INT NOT NULL,
    FOREIGN KEY(User_Id) REFERENCES User(Id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Address (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Street VARCHAR(100),
    Zip_Code VARCHAR(10),
    City VARCHAR(50),
	Province VARCHAR(50),
    Country VARCHAR(50),
    Instructions VARCHAR(200),
    
	User_Id INT NOT NULL,
    FOREIGN KEY(User_Id) REFERENCES User(Id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Orders (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Quantity INT NOT NULL,
    Data DATE NOT NULL,
    TotalCost DECIMAL(10,2) NOT NULL,
    Status VARCHAR(50) NOT NULL,
    
    User_Id INT NOT NULL,
    FOREIGN KEY(User_Id) REFERENCES User(Id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT,
	Address_Id INT NOT NULL,
        FOREIGN KEY(Address_Id) REFERENCES Address(Id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT,
	Payment_Id INT NOT NULL,
        FOREIGN KEY(Payment_Id) REFERENCES Payment(Id)
		ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Product_Order (
    Order_Id INT NOT NULL,
	Product_Id INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    IVA DECIMAL(4,2) NOT NULL,

	PRIMARY KEY(Order_Id, Product_Id),
	FOREIGN KEY(Product_Id) REFERENCES Product(Id)
							ON UPDATE CASCADE
                            ON DELETE RESTRICT,
    FOREIGN KEY(Order_Id) REFERENCES Orders(Id)
							ON UPDATE CASCADE
                            ON DELETE RESTRICT
);

INSERT INTO Product (Id, Name, Description, Price, Weight, Image, Quantity, IVA) VALUES
('01', 'Cioccolato fondente', 'Cioccolato fondente biologico al 70%, prodotto solo con fave di cacao biologiche di alta qualit� provenienti da coltivazioni sostenibili, con un sapore intenso e persistente', 4.50, 0.3, null, 60, 10),
('02', 'Barrette energetiche vegane', 'Barrette energetiche vegane al cacao e cocco, realizzate solo con ingredienti naturali come datteri, mandorle, nocciole, semi di girasole, semi di zucca, cacao e cocco, senza zuccheri aggiunti', 2.50, 0.1, null, 200, 10),
('03', 'Caff� biologico', 'Caff� biologico al 100% arabica, coltivato in modo sostenibile e selezionato dalle migliori piantagioni, dal gusto intenso e persistente con note fruttate e cioccolatose', 5.00, 0.2, null, 50, 10),
('04', 'Birra artigianale', 'Birra artigianale con ingredienti naturali, prodotta con acqua di sorgente, malti selezionati, luppoli aromatici e lieviti naturali, dal gusto equilibrato e aromatico', 3.50, 0.4, null, 80, 10),
('05', 'Miele biologico', 'Miele di acacia biologico e naturale, raccolto da api che si nutrono solo di fiori di acacia, dal sapore delicato e dolce con propriet� benefiche per la salute', 10.00, 0.5, null, 100, 10),
('06', 'T� verde biologico', 'T� verde biologico con erbe naturali, selezionato dalle migliori coltivazioni biologiche e arricchito con erbe aromatiche come menta, limone e zenzero, per un sapore fresco e tonificante', 6.00, 0.1, null, 30, 10),
('07', 'Frutta biologica', 'Cesto di frutta biologica di stagione, selezionata con cura dalle migliori coltivazioni biologiche e ricca di vitamine e antiossidanti per un\'alimentazione sana e gustosa', 15.00, 1.0, null, 20, 10),
('08', 'Biscotti biologici', 'Biscotti biologici al burro e limone, preparati solo con ingredienti naturali e biologici come burro, farina, zucchero di canna e scorza di limone, dal sapore fragrante e croccante', 3.00, 0.2, null, 100, 10),
('09', 'Succo di mela biologico', 'Il nostro succo di mela biologico � ottenuto da mele fresche, coltivate senza l\'uso di pesticidi o altre sostanze chimiche dannose. Non contiene conservanti, zuccheri aggiunti o coloranti artificiali. Ogni bottiglia contiene 70cl di succo di mela.', 2.50, 0.5, null, 70, 10),
('10', 'Marmellata biologica', 'La nostra marmellata biologica � fatta con frutta biologica coltivata localmente e senza l\'uso di pesticidi o altri prodotti chimici nocivi. Non contiene conservanti o coloranti artificiali. Ogni barattolo contiene 300g di marmellata.', 4.00, 0.3, null, 50, 10),
('11', 'Spazzolino biodegradabile', 'Questo spazzolino biodegradabile � realizzato in bamboo naturale, un materiale ecologico e sostenibile. Le setole sono morbide ma resistenti e garantiscono una pulizia accurata dei denti. Il manico ergonomico e leggero rende facile e comodo l\'uso quotidiano. Ogni confezione contiene un singolo spazzolino.', 3.00, 0.05, null, 200, 10),
('12', 'Bottiglia in acciaio inox', 'La nostra bottiglia in acciaio inox � resistente, riutilizzabile e priva di sostanze chimiche nocive come il BPA. Pu� contenere fino a 500ml di liquido e mantiene la temperatura degli alimenti per diverse ore. La bottiglia � dotata di un tappo a vite ermetico e di un comodo beccuccio per bere.', 15.00, 0.3, null, 100, 10),
('13', 'Sacchetti riutilizzabili', 'Questi sacchetti riutilizzabili sono realizzati in cotone biologico, un materiale sostenibile e resistente. Sono ideali per la spesa o per il trasporto di oggetti di piccole dimensioni. Il set include tre sacchetti di diverse dimensioni, con comode chiusure a cordino.', 10.00, 0.1, null, 50, 10),
('14', 'Spugna naturale', 'Questa spugna naturale � adatta per la pulizia della casa e proviene da coltivazioni sostenibili. Grazie alla sua composizione naturale, non graffia le superfici delicati. La spugna � facile da usare e da pulire dopo l\'uso.', 4.50, 0.2, 'spugna_naturale.jpg', 80, 10),
('15', 'Bicchieri in vetro riciclato', 'Questo set di bicchieri � realizzato interamente in vetro riciclato, contribuendo cos� alla salvaguardia dell\'ambiente. Grazie alla loro trasparenza, i bicchieri offrono un\'esperienza di degustazione superiore rispetto a quelli in plastica o altri materiali. Il vetro � resistente e pu� essere facilmente lavato in lavastoviglie.', 20.00, 1.0, null, 30, 10),
('16', 'Panno per la pulizia', 'Questo panno per la pulizia � realizzato in microfibra riciclata e rappresenta una soluzione ecologica e sostenibile per la pulizia della casa. La sua struttura in microfibra permette di rimuovere facilmente lo sporco e la polvere, senza utilizzare prodotti chimici dannosi per l\'ambiente. Inoltre, il panno � lavabile in lavatrice e pu� essere riutilizzato numerose volte.', 6.00, 0.1, null, 100, 10),
('17', 'Sapone solido biologico', 'Questo sapone solido biologico � realizzato con ingredienti naturali e biologici, tra cui l\'olio essenziale di lavanda. Grazie alla sua formula delicata, il sapone deterge la pelle senza irritarla o seccarla. Inoltre, il sapone solido rappresenta una soluzione ecologica e sostenibile, poich� riduce l\'uso di plastica rispetto ai flaconi di sapone liquido.', 4.00, 0.1, null, 70, 10),
('18', 'Carta igienica ecologica', 'Questa carta igienica ecologica � realizzata al 100% con materiali riciclati, riducendo cos� l\'impatto ambientale legato all\'estrazione delle materie prime. La carta igienica � morbida e resistente, garantendo un\'esperienza di pulizia efficace e confortevole. Inoltre, la confezione � realizzata con materiali biodegradabili e riciclabili.', 2.50, 0.2, null, 200, 10),
('19', 'Asciugamani in cotone biologico', 'Set di asciugamani in cotone biologico, morbidi al tatto e altamente assorbenti, ideali per l\'utilizzo quotidiano. Il set include tre asciugamani di diverse dimensioni: uno grande per il viso, uno medio per le mani e uno piccolo per il viso.', 30.00, 0.5, null, 40, 10),
('20', 'Sapone per i piatti biologico', 'Sapone per i piatti biologico al limone, delicato sulla pelle e altamente efficace contro lo sporco ostinato. Formulato con ingredienti naturali al 100% e privo di sostanze chimiche nocive, � sicuro da usare su qualsiasi tipo di stoviglie.', 5.00, 0.2, null, 60, 10),
('21', 'T-shirt biologica', 'T-shirt biologica in cotone al 100%, leggera e traspirante, ideale per l\'estate. Realizzata con materiali di alta qualit�, la t-shirt � resistente alle pieghe e facile da lavare.', 20.00, 0.2, null, 50, 10),
('22', 'Pantaloncini in lino biologico', 'Pantaloncini in lino biologico, leggeri e confortevoli, perfetti per l\'estate. Realizzati con materiali di alta qualit�, i pantaloncini sono resistenti e facili da lavare. Disponibili in diverse taglie.', 30.00, 0.3, null, 30, 10),
('23', 'Maglione in lana riciclata al 100%', 'Maglione in lana riciclata al 100%, caldo e morbido al tatto, ideale per l\'inverno. Realizzato con materiali sostenibili, il maglione � resistente e facile da lavare. Disponibile in diverse taglie e colori.', 50.00, 0.5, null, 20, 10),
('24', 'Scarpe in canapa biologica', 'Scarpe in canapa biologica, leggere e resistenti, ideali per l\'estate. Realizzate con materiali sostenibili, le scarpe sono morbide al tatto e facili da lavare. Disponibili in diverse taglie e colori.', 60.00, 0.6, null, 10, 10),
('25', 'Camicia in lino biologico', 'Camicia in lino biologico, leggera e traspirante, perfetta per l\'estate. Realizzata con materiali di alta qualit�, la camicia � morbida al tatto e resistente alle pieghe. Disponibile in diverse taglie.', 40.00, 0.3, null, 40, 10),
('26', 'Jeans in denim riciclato', 'I nostri jeans riciclati sono realizzati in denim riciclato di alta qualit�, ottenuto da tessuti di jeans pre-esistenti che sono stati puliti e rigenerati per creare un nuovo tessuto. Il risultato � un prodotto sostenibile ed eco-friendly, che non solo riduce l\'impatto ambientale ma offre anche un\'alternativa alla produzione di tessuti da zero. Ogni paio di jeans � unico e presenta dettagli che raccontano la sua storia.', 45.00, 0.4, null, 30, 10),
('27', 'Giacca in tessuto tecnico riciclato', 'La nostra giacca in tessuto tecnico riciclato � realizzata al 100% con materiali riciclati di alta qualit�, tra cui bottiglie di plastica e tessuti pre-esistenti. Il tessuto tecnico offre una maggiore resistenza alle intemperie e una maggiore durata nel tempo, rendendo questa giacca un capo perfetto per le attivit� all\'aperto. Inoltre, la scelta di tessuti riciclati riduce l\'impatto ambientale e contribuisce a ridurre lo spreco di risorse.', 80.00, 0.5, null, 15, 10),
('28', 'Felpa biologica', 'La nostra felpa biologica � realizzata al 100% in cotone biologico, una scelta sostenibile per l\'ambiente e per la salute delle persone. Il cotone biologico viene coltivato senza l\'uso di pesticidi e prodotti chimici dannosi, riducendo l\'impatto ambientale e garantendo un prodotto privo di sostanze nocive. La felpa � disponibile in diverse taglie e colori per adattarsi alle esigenze di ogni persona.', 35.00, 0.4, null, 25, 10),
('29', 'Cappello in cotone biologico', 'Il nostro cappello in cotone biologico � realizzato al 100% in cotone biologico, una scelta sostenibile e eco-friendly. Il cotone biologico viene coltivato senza l\'uso di pesticidi e prodotti chimici dannosi, riducendo l\'impatto ambientale e garantendo un prodotto privo di sostanze nocive. Il cappello ha una visiera che protegge dal sole e dalla pioggia, ed � disponibile in diverse taglie e colori per adattarsi alle esigenze di ogni persona.', 25.00, 0.1, null, 50, 10),
('30', 'Giacca in pelle vegetale', 'Questa giacca � realizzata in pelle vegetale, un materiale che non utilizza alcuna pelle animale. � stata progettata per garantire resistenza e durata nel tempo, con un design elegante e senza tempo. La giacca � disponibile in diverse taglie per soddisfare le esigenze di ogni cliente.', 150.00, 1.0, null, 5, 10),
('31', 'Bicicletta pieghevole', 'Questa bicicletta pieghevole � realizzata in alluminio riciclato, un materiale resistente e leggero che consente di trasportare facilmente la bicicletta ovunque si voglia. Grazie alla sua funzione pieghevole, la bicicletta � facile da riporre e trasportare, perfetta per chi ama viaggiare e spostarsi in citt�.', 500.00, 10.0, null, 5, 22),
('32', 'Scooter elettrico', 'Questo scooter elettrico � dotato di una batteria ricaricabile e ha un design moderno ed elegante. � ideale per chi cerca un mezzo di trasporto ecologico e pratico per gli spostamenti quotidiani. Grazie alle sue caratteristiche, lo scooter � in grado di raggiungere alte velocit� e di coprire lunghe distanze senza problemi.', 1200.00, 15.0, null, 3, 22),
('33', 'Monopattino elettrico', 'Questo monopattino elettrico � dotato di freni a disco per garantire la massima sicurezza durante la guida. � leggero e facile da trasportare, perfetto per gli spostamenti in citt�. La batteria � facilmente ricaricabile e il monopattino � disponibile in diversi colori per soddisfare le esigenze di ogni cliente.', 300.00, 5.0, null, 10, 22),
('34', 'Borsone per bicicletta', 'Questo borsone per bicicletta � realizzato in tessuto riciclato ed � impermeabile, perfetto per proteggere i propri oggetti durante gli spostamenti in bicicletta anche sotto la pioggia. Il borsone � disponibile in diverse taglie e colori, per soddisfare le esigenze di ogni cliente.', 50.00, 1.0, null, 20, 22),
('35', 'Casco per bicicletta', 'Questo casco per bicicletta � leggero e resistente, progettato per garantire la massima sicurezza durante la guida. � disponibile in diverse taglie e colori, per soddisfare le esigenze di ogni cliente. Grazie al suo design elegante e funzionale, il casco � perfetto per gli appassionati di ciclismo.', 40.00, 0.5, null, 30, 22),
('36', 'Borsa per monopattino', 'Questa borsa per monopattino � perfetta per chi vuole portare con s� tutti gli oggetti necessari in modo sicuro e protetto dalla pioggia. La borsa � realizzata in tessuto riciclato, in linea con la nostra politica di sostenibilit� ambientale.', 25.00, 0.5, null, 40, 22),
('37', 'Lucchetto per bicicletta', 'Questo lucchetto antifurto per bicicletta � la soluzione ideale per proteggere la tua bicicletta da furti e atti vandalici. La sua struttura solida e resistente � stata progettata per durare nel tempo e garantire la massima sicurezza.', 20.00, 0.5, null, 50, 22),
('38', 'Seggiolino per bici', 'Il seggiolino per bici � pensato per offrire il massimo della sicurezza e del comfort ai bambini che accompagni in bicicletta. Il seggiolino � facile da installare e si adatta perfettamente alla maggior parte dei modelli di bicicletta.', 60.00, 1.5, null, 15, 22),
('39', 'Bicicletta a pedalata assistita', 'Questa bicicletta a pedalata assistita � la soluzione perfetta per chi cerca un modo alternativo ed eco-sostenibile di spostarsi in citt�. Grazie al motore elettrico, la pedalata assistita ti permette di raggiungere facilmente ogni meta, senza sforzi eccessivi.', 900.00, 12.0, null, 5, 22),
('40', 'Portapacchi per bici', 'Il portapacchi regolabile per bicicletta � stato progettato per offrire la massima flessibilit� e comodit� nella gestione dei tuoi oggetti. Realizzato con materiali riciclati, � una scelta ecologica e sostenibile per chi cerca un modo pratico di trasportare i propri oggetti sulla bicicletta.', 30.00, 0.8, null, 30, 22);


INSERT INTO User (Id, Name, Surname, Email, Password, Date_Registration, Telephone, Administrator) VALUES
(1, 'Mario', 'Rossi', 'mario.rossi@gmail.com', 'password123', '2022-01-15', '333-1234567', false),
(2, 'Luigi', 'Verdi', 'luigi.verdi@hotmail.com', 'password456', '2022-02-10', '333-2345678', false),
(3, 'Giovanni', 'Bianchi', 'giovanni.bianchi@yahoo.com', 'password789', '2022-03-05', '333-3456789', false),
(4, 'Anna', 'Neri', 'anna.neri@gmail.com', 'passwordABC', '2022-04-01', '333-4567890', false),
(5, 'Francesca', 'Gialli', 'francesca.gialli@gmail.com', 'passwordDEF', '2022-05-10', '333-5678901', false),
(6, 'admin', 'admin', 'admin@admin', 'admin', '2023-04-15', '333-3333333', true);
