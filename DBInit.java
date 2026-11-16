import java.sql.*;

public class DBInit {
    public static void main(String[] args) {
        Connection conn = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "wildlife", "wildlife");

            PreparedStatement psS = conn.prepareStatement(
                "INSERT INTO sanctuaries (id, name, state, description, key_animals, best_time, image_url) " +
                "VALUES (seq_sanctuaries.NEXTVAL, ?, ?, ?, ?, ?, ?)"
            );

            String[][] sanctuaries = {
                {
                    "Jim Corbett National Park",
                    "Uttarakhand",
                    "India's oldest national park, established in 1936 to protect the endangered Bengal tiger. Set amidst the foothills of the Himalayas, it features diverse flora, dense sal forests, and rich wildlife.",
                    "Bengal Tiger, Asian Elephant, Leopard, Sambar Deer",
                    "November to June",
                    "jimcorbett.jpg"
                },
                {
                    "Gir National Park",
                    "Gujarat",
                    "The sole home of the majestic Asiatic Lion in the wilderness. Spread across deciduous forests and grasslands, it offers spectacular safari experiences and conservation success.",
                    "Asiatic Lion, Indian Leopard, Striped Hyena, Chital",
                    "December to March",
                    "gir.jpg"
                },
                {
                    "Periyar Tiger Reserve",
                    "Kerala",
                    "Located high in the Cardamom and Pandalam Hills of the southern Western Ghats. Famous for its picturesque lake where wild elephants, tigers, and rare birds congregate in harmony.",
                    "Bengal Tiger, Asian Elephant, Nilgiri Tahr, Lion-tailed Macaque",
                    "September to April",
                    "periyar.jpg"
                },
                {
                    "Chinnar Wildlife Sanctuary",
                    "Kerala",
                    "Nestled in the rain-shadow region of the Western Ghats in Idukki. Known for its thorny scrub forest, dry deciduous trees, and being home to the endangered Grizzled Giant Squirrel.",
                    "Grizzled Giant Squirrel, Star Tortoise, Indian Leopard, Gaur",
                    "October to February",
                    "chinnar.jpg"
                },
                {
                    "Wayanad Wildlife Sanctuary",
                    "Kerala",
                    "An integral part of the Nilgiri Biosphere Reserve. Lush evergreen forests home to large herds of elephants, tigers, leopards, and diverse avian species.",
                    "Asian Elephant, Bengal Tiger, Indian Peafowl, Gaur",
                    "October to May",
                    "wayanad.jpg"
                },
                {
                    "Bondla Wildlife Sanctuary",
                    "Goa",
                    "A popular sanctuary located in Ponda taluka of Goa. Surrounded by moist deciduous forests with rich biodiversity, botanical gardens, mini zoo, and tranquil nature trails.",
                    "Sambar Deer, Indian Peafowl, Leopard, Wild Boar",
                    "October to April",
                    "bondla.jpg"
                },
                {
                    "Karnala Bird Sanctuary",
                    "Maharashtra",
                    "Located in the Raigad district near Mumbai and Navi Mumbai. Home to more than 220 species of resident and migratory birds surrounding the historic Karnala Fort peak.",
                    "Malabar Whistling Thrush, Peregrine Falcon, Ashy Minivet, Parakeets",
                    "October to April",
                    "karnala.jpg"
                },
                {
                    "Wild Ass Sanctuary (Little Rann of Kutch)",
                    "Gujarat",
                    "One of the largest wildlife sanctuaries in India, covering salt marshes and desert scrublands. It is the last refuge on earth for the endangered Indian Wild Ass (Khur).",
                    "Indian Wild Ass (Khur), Desert Fox, Blackbuck, Greater Flamingo",
                    "November to March",
                    "wildass.jpg"
                },
                {
                    "Dandeli Wildlife Sanctuary",
                    "Karnataka",
                    "A pristine sanctuary located on the banks of Kali River in Uttara Kannada. Dense deciduous forests harboring black panthers, tigers, and hornbills.",
                    "Black Panther, Bengal Tiger, Malabar Pied Hornbill, Elephant",
                    "October to May",
                    "dandeli.jpg"
                },
                {
                    "Sundarbans National Park",
                    "West Bengal",
                    "A UNESCO World Heritage site and biosphere reserve in the Ganges Delta. Renowned for mangrove forests and the legendary swimming Royal Bengal Tigers.",
                    "Royal Bengal Tiger, Estuarine Crocodile, Gangetic Dolphin, Spotted Deer",
                    "September to March",
                    "sundarbans.jpg"
                },
                {
                    "Kaziranga National Park",
                    "Assam",
                    "A world-famous UNESCO World Heritage Site hosting two-thirds of the world's great one-horned rhinoceroses along the fertile floodplains of the Brahmaputra River.",
                    "One-horned Rhinoceros, Royal Bengal Tiger, Wild Water Buffalo, Swamp Deer",
                    "November to April",
                    "rhino.jpg"
                },
                {
                    "Ranthambore National Park",
                    "Rajasthan",
                    "One of northern India's premier tiger reserves, featuring the historic 10th-century Ranthambore Fort overlooking picturesque lakes and dry deciduous forests.",
                    "Bengal Tiger, Leopard, Nilgai, Marsh Crocodile",
                    "October to April",
                    "tigergallery.jpg"
                }
            };

            for (String[] s : sanctuaries) {
                psS.setString(1, s[0]);
                psS.setString(2, s[1]);
                psS.setString(3, s[2]);
                psS.setString(4, s[3]);
                psS.setString(5, s[4]);
                psS.setString(6, s[5]);
                psS.executeUpdate();
            }
            psS.close();
            System.out.println("Sanctuaries inserted: " + sanctuaries.length);

            PreparedStatement psA = conn.prepareStatement(
                "INSERT INTO animals (id, name, category, scientific_name, habitat, found_in, description, image_url) " +
                "VALUES (seq_animals.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)"
            );

            String[][] animals = {
                {
                    "Bengal Tiger",
                    "Animal",
                    "Panthera tigris tigris",
                    "Tropical rainforests, marshes, grasslands",
                    "Sundarbans, Jim Corbett, Ranthambore, Bandhavgarh",
                    "The Bengal Tiger is the national animal of India and one of the largest big cats. Known for its distinct orange coat with dark stripes, it represents supreme strength and agility in Indian wildlife.",
                    "image1.jpg"
                },
                {
                    "Indian Rhinoceros",
                    "Animal",
                    "Rhinoceros unicornis",
                    "Alluvial grasslands and riverine swamps",
                    "Kaziranga National Park, Pobitora, Manas",
                    "The Indian One-horned Rhinoceros is a massive herbivore characterized by its thick, armour-plated grey-brown hide and a single prominent keratin horn.",
                    "image2.jpg"
                },
                {
                    "Asian Elephant",
                    "Animal",
                    "Elephas maximus indicus",
                    "Tropical and subtropical moist broadleaf forests",
                    "Periyar, Wayanad, Corbett, Kaziranga",
                    "The Asian Elephant is the largest living terrestrial mammal in Asia. Highly social and intelligent, they roam across migration corridors and maintain forest ecology.",
                    "image3.jpg"
                },
                {
                    "Indian Leopard",
                    "Animal",
                    "Panthera pardus fusca",
                    "Deciduous forests, scrublands, rocky hills",
                    "Gir, Dandeli, Jim Corbett, Jawai",
                    "The Indian Leopard is an elusive and agile big cat capable of climbing trees effortlessly while carrying heavy prey. Its rosette patterns provide camouflage.",
                    "image4.jpg"
                },
                {
                    "Asiatic Lion",
                    "Animal",
                    "Panthera leo persica",
                    "Dry deciduous forests and savannah habitats",
                    "Gir National Park and Wildlife Sanctuary, Gujarat",
                    "Slightly smaller than African lions, Asiatic lions feature a distinctive longitudinal fold of skin running along their belly and a sparser mane in males.",
                    "image5.jpg"
                },
                {
                    "Blackbuck",
                    "Animal",
                    "Antilope cervicapra",
                    "Open grasslands and semi-arid plains",
                    "Velavadar National Park, Tal Chhapar, Point Calimere",
                    "The Blackbuck is an elegant Indian antelope famous for the striking spiral horns of males and exceptional jumping ability, reaching speeds up to 80 km/h.",
                    "image6.jpg"
                },
                {
                    "Nilgiri Tahr",
                    "Animal",
                    "Nilgiritragus hylocrius",
                    "Montane shola grasslands and rocky crags",
                    "Eravikulam National Park, Nilgiri Hills, Anamalai",
                    "The Nilgiri Tahr is a sturdy wild ungulate endemic to the high elevations of the Western Ghats, possessing short, coarse fur and curved horns.",
                    "image7.jpg"
                },
                {
                    "Kashmir Stag (Hangul)",
                    "Animal",
                    "Cervus hanglu hanglu",
                    "Dense riverine forests and alpine meadows",
                    "Dachigam National Park, Jammu & Kashmir",
                    "The Hangul is a critically endangered subspecies of red deer native to the valleys of Kashmir, renowned for its magnificent 11 to 16 point antlers.",
                    "image8.jpg"
                },
                {
                    "Indian Wild Ass (Khur)",
                    "Animal",
                    "Equus hemionus khur",
                    "Saline mudflats, desert steppes and thorn scrub",
                    "Little Rann of Kutch, Gujarat",
                    "The Indian Wild Ass is an extraordinarily resilient desert equus capable of running at 50 km/h across salty baked clay desert terrain.",
                    "wildass.jpg"
                },
                {
                    "Spotted Deer (Chital)",
                    "Animal",
                    "Axis axis",
                    "Open grasslands and dry deciduous woodlands",
                    "Kanha, Corbett, Nagarhole, Bandipur",
                    "The Chital or Spotted Deer is the most common deer species in Indian forests, celebrated for its golden-brown coat dotted with permanent white spots.",
                    "deer.jpg"
                },
                {
                    "Great Indian Hornbill",
                    "Bird",
                    "Buceros bicornis",
                    "Dense primary rainforests and canopy heights",
                    "Western Ghats, Arunachal Pradesh, Kaziranga",
                    "The Great Indian Hornbill is an impressive bird with a massive yellow-and-black casque atop its bill. Its heavy wings generate a distinctive rushing sound in flight.",
                    "image9.jpg"
                },
                {
                    "Rose-ringed Parakeet",
                    "Bird",
                    "Psittacula krameri",
                    "Woodlands, agricultural landscapes, urban parks",
                    "Widely distributed throughout India",
                    "A vibrant green parakeet with long tapering tail feathers. Adult males display a prominent black and rose-pink neck ring.",
                    "parakeetgallery.jpg"
                },
                {
                    "Malabar Pied Hornbill",
                    "Bird",
                    "Anthracoceros coronatus",
                    "Evergreen and moist deciduous coastal forests",
                    "Dandeli, Western Ghats, Central India",
                    "A large canopy-dwelling hornbill featuring pied black and white plumage with a huge creamy casque that serves as a resonating chamber for vocal calls.",
                    "hornbillgallery.jpg"
                },
                {
                    "Indian Peafowl (Peacock)",
                    "Bird",
                    "Pavo cristatus",
                    "Deciduous forests, scrublands, village borders",
                    "Throughout Indian subcontinent, Rajasthan, Gujarat",
                    "The National Bird of India, famous worldwide for the male's iridescent blue plumage and magnificent train of elongated eye-spotted covert feathers.",
                    "parakeetin.jpg"
                }
            };

            for (String[] a : animals) {
                psA.setString(1, a[0]);
                psA.setString(2, a[1]);
                psA.setString(3, a[2]);
                psA.setString(4, a[3]);
                psA.setString(5, a[4]);
                psA.setString(6, a[5]);
                psA.setString(7, a[6]);
                psA.executeUpdate();
            }
            psA.close();
            System.out.println("Animals & Birds inserted: " + animals.length);

            System.out.println("Oracle Database seeded successfully!");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (Exception ignored) {}
            }
        }
    }
}
