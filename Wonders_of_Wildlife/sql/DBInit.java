package sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Standalone Utility to initialize and seed the Oracle Database for Wonders of Wildlife.
 * Seeds 15 Sanctuaries & 20 Wildlife Species (Animals and Birds) with exact matching images.
 */
public class DBInit {
    private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
    private static final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
    private static final String USER = "wildlife";
    private static final String PASS = "wildlife";

    public static void main(String[] args) {
        Connection conn = null;
        try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("Connected to Oracle Database successfully.");

            // Clear existing records to avoid duplicates and ensure clean ID sequence
            conn.createStatement().execute("DELETE FROM sanctuaries");
            conn.createStatement().execute("DELETE FROM animals");

            // Reset sequences if desired or continue
            try {
                conn.createStatement().execute("DROP SEQUENCE seq_sanctuaries");
                conn.createStatement().execute("CREATE SEQUENCE seq_sanctuaries START WITH 1 INCREMENT BY 1 NOCACHE");
                conn.createStatement().execute("DROP SEQUENCE seq_animals");
                conn.createStatement().execute("CREATE SEQUENCE seq_animals START WITH 1 INCREMENT BY 1 NOCACHE");
            } catch (Exception ignored) {}

            // 1. SEED SANCTUARIES (15 Renowned Sanctuaries & National Parks across India)
            PreparedStatement psS = conn.prepareStatement(
                "INSERT INTO sanctuaries (id, name, state, description, key_animals, best_time, image_url) " +
                "VALUES (seq_sanctuaries.NEXTVAL, ?, ?, ?, ?, ?, ?)"
            );

            String[][] sanctuaries = {
                {
                    "Jim Corbett National Park",
                    "Uttarakhand",
                    "India's oldest national park, established in 1936 along the Ramganga River in the sub-Himalayan belt. Celebrated for dense sal forests, deep ravines, and as the birthplace of Project Tiger.",
                    "Bengal Tiger, Asian Elephant, Indian Leopard, Sambar Deer",
                    "November to June",
                    "jimcorbett.jpg"
                },
                {
                    "Gir National Park",
                    "Gujarat",
                    "The last remaining natural refuge on Earth for the endangered Asiatic Lion. Spanning dry deciduous teak forests and undulating rocky ridges in the Saurashtra peninsula.",
                    "Asiatic Lion, Indian Leopard, Striped Hyena, Chital, Chousingha",
                    "December to March",
                    "gir.jpg"
                },
                {
                    "Kaziranga National Park",
                    "Assam",
                    "A UNESCO World Heritage Site along the Brahmaputra River floodplains, sheltering two-thirds of the world's population of the great Indian one-horned rhinoceros.",
                    "One-horned Rhinoceros, Royal Bengal Tiger, Wild Water Buffalo, Swamp Deer",
                    "November to April",
                    "kaziranga.jpg"
                },
                {
                    "Periyar Tiger Reserve",
                    "Kerala",
                    "High in the Cardamom Hills of the Western Ghats, Periyar is famous for its scenic lake where wild elephant herds and tigers roam undisturbed amidst tropical evergreen hills.",
                    "Asian Elephant, Bengal Tiger, Nilgiri Tahr, Lion-tailed Macaque",
                    "September to April",
                    "periyar.jpg"
                },
                {
                    "Sundarbans National Park",
                    "West Bengal",
                    "The largest mangrove delta on Earth and a UNESCO World Heritage Biosphere. Famous for its tides, tangled root networks, and the legendary swimming Royal Bengal Tigers.",
                    "Royal Bengal Tiger, Estuarine Crocodile, Gangetic Dolphin, Spotted Deer",
                    "September to March",
                    "sundarbans.jpg"
                },
                {
                    "Ranthambore National Park",
                    "Rajasthan",
                    "One of northern India's premier tiger reserves, marked by the 10th-century Ranthambore fortress towering over padm talab, dense dhok trees, and ancient banyan groves.",
                    "Bengal Tiger, Indian Leopard, Marsh Crocodile, Nilgai",
                    "October to April",
                    "ranthambore.jpg"
                },
                {
                    "Keoladeo National Park (Bharatpur)",
                    "Rajasthan",
                    "A world-renowned avifauna sanctuary and UNESCO World Heritage wetland. Serves as a winter haven for thousands of migratory waterbirds including cranes, pelicans, and storks.",
                    "Sarus Crane, Siberian Crane, Painted Stork, Spot-billed Pelican, Python",
                    "October to February",
                    "keoladeo.jpg"
                },
                {
                    "Kanha National Park",
                    "Madhya Pradesh",
                    "The largest national park of Central India and the inspiration for Rudyard Kipling's The Jungle Book. Renowned for open sal meadows and the revival of the hard-ground Barasingha.",
                    "Barasingha (Swamp Deer), Royal Bengal Tiger, Leopard, Dhole (Wild Dog)",
                    "October to June",
                    "kanha.jpg"
                },
                {
                    "Chinnar Wildlife Sanctuary",
                    "Kerala",
                    "Nestled in the rain-shadow region of the southern Western Ghats in Idukki. Renowned for its thorny scrub vegetation, dry deciduous forests, and the rare Grizzled Giant Squirrel.",
                    "Grizzled Giant Squirrel, Star Tortoise, Indian Leopard, Gaur",
                    "October to February",
                    "chinnar.jpg"
                },
                {
                    "Wayanad Wildlife Sanctuary",
                    "Kerala",
                    "An integral part of the Nilgiri Biosphere Reserve. Lush evergreen rainforests and bamboo thickets home to large herds of elephants, tigers, leopards, and diverse avian fauna.",
                    "Asian Elephant, Bengal Tiger, Indian Peafowl, Gaur, Malabar Squirrel",
                    "October to May",
                    "wayanad.jpg"
                },
                {
                    "Mudumalai National Park",
                    "Tamil Nadu",
                    "Situated at the tri-junction of Tamil Nadu, Karnataka, and Kerala on the northwestern slopes of the Nilgiri Hills. An essential wildlife corridor for elephant and tiger migrations.",
                    "Asian Elephant, Bengal Tiger, Indian Leopard, Gaur, Indian Vulture",
                    "October to May",
                    "mudumalai.jpg"
                },
                {
                    "Bondla Wildlife Sanctuary",
                    "Goa",
                    "A lush sanctuary located in Ponda taluka of Goa. Surrounded by moist deciduous woodlands with rich biodiversity, botanical gardens, a rescue center, and scenic forest trails.",
                    "Sambar Deer, Indian Peafowl, Leopard, Wild Boar, Giant Squirrel",
                    "October to April",
                    "bondla.jpg"
                },
                {
                    "Karnala Bird Sanctuary",
                    "Maharashtra",
                    "Located around the historic 12th-century Karnala pinnacle in Raigad. Home to over 222 species of resident and migratory woodland birds in the northern Western Ghats.",
                    "Malabar Whistling Thrush, Peregrine Falcon, Ashy Minivet, Parakeets",
                    "October to April",
                    "karnala.jpg"
                },
                {
                    "Wild Ass Sanctuary (Little Rann of Kutch)",
                    "Gujarat",
                    "Covering vast salt marshes and saline desert flats. It is the sole sanctuary on Earth dedicated to preserving the endangered Indian Wild Ass (Khur).",
                    "Indian Wild Ass (Khur), Desert Fox, Blackbuck, Greater Flamingo",
                    "November to March",
                    "wildass1.jpg"
                },
                {
                    "Dandeli Wildlife Sanctuary",
                    "Karnataka",
                    "A pristine sanctuary on the banks of Kali River in Uttara Kannada. Dense deciduous canopies that harbor elusive black panthers, tigers, elephants, and great hornbills.",
                    "Black Panther, Bengal Tiger, Malabar Pied Hornbill, Asian Elephant",
                    "October to May",
                    "dandeli.jpg"
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
            System.out.println("Sanctuaries successfully seeded: " + sanctuaries.length);

            // 2. SEED ANIMALS AND BIRDS (20 Species: 13 Mammals/Animals + 7 Birds of India)
            PreparedStatement psA = conn.prepareStatement(
                "INSERT INTO animals (id, name, category, scientific_name, habitat, found_in, description, image_url) " +
                "VALUES (seq_animals.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)"
            );

            String[][] animals = {
                // Animals / Mammals
                {
                    "Bengal Tiger",
                    "Animal",
                    "Panthera tigris tigris",
                    "Tropical rainforests, alluvial grasslands, mangrove swamps",
                    "Sundarbans, Jim Corbett, Ranthambore, Bandhavgarh, Kanha",
                    "The Royal Bengal Tiger is the national animal of India and an apex predator representing power, stealth, and grace. Recognized by its amber coat and black vertical stripes, India shelters over 70% of the wild global tiger population through Project Tiger.",
                    "bengaltiger.jpg"
                },
                {
                    "Indian Rhinoceros",
                    "Animal",
                    "Rhinoceros unicornis",
                    "Alluvial floodplains, riverine tall grasslands, marshy swamps",
                    "Kaziranga National Park, Pobitora, Manas, Jaldapara",
                    "Also known as the Greater One-Horned Rhinoceros, this prehistoric herbivore is identified by its armour-like pebbled skin folds and single keratin horn. Thanks to strict conservation in Assam, its numbers have rebounded dramatically from fewer than 200 to over 3,700 today.",
                    "rhino.jpg"
                },
                {
                    "Asian Elephant",
                    "Animal",
                    "Elephas maximus indicus",
                    "Tropical evergreen, moist deciduous forests, bamboo belts",
                    "Periyar, Wayanad, Corbett, Mudumalai, Kaziranga",
                    "The Asian Elephant is a keystone species and cultural symbol in India. Highly intelligent and matriarchal, elephant herds create forest pathways, disperse giant seeds, and shape ecosystems across vital wildlife migration corridors.",
                    "elephantgallery.jpg"
                },
                {
                    "Indian Leopard",
                    "Animal",
                    "Panthera pardus fusca",
                    "Deciduous forests, scrublands, rocky kopjes, tea estates",
                    "Gir, Dandeli, Jim Corbett, Jawai, Bandipur",
                    "The Indian Leopard is an elusive and exceptionally adaptable big cat known for its rosette patterns and remarkable tree-climbing prowess. It can haul heavy prey up into trees to keep it safe from other ground predators.",
                    "leopard.jpg"
                },
                {
                    "Asiatic Lion",
                    "Animal",
                    "Panthera leo persica",
                    "Dry deciduous teak forests, savannah thorn scrublands",
                    "Gir National Park & Wildlife Sanctuary, Gujarat",
                    "The Asiatic Lion exists only in Gujarat's Gir forest. Distinguished from African lions by a longitudinal skin fold running along its belly and a sparser mane in males, it is a monumental success story of Indian wildlife conservation.",
                    "lion.png"
                },
                {
                    "Blackbuck",
                    "Animal",
                    "Antilope cervicapra",
                    "Open savannah grasslands, semi-arid flat plains",
                    "Velavadar National Park, Tal Chhapar, Point Calimere",
                    "The Blackbuck is one of the fastest antelopes on Earth, reaching speeds up to 80 km/h. Adult males feature striking black-and-white coats and magnificent long corkscrew spiral horns, held sacred by the Bishnoi community.",
                    "blackbuckgallery.jpg"
                },
                {
                    "Nilgiri Tahr",
                    "Animal",
                    "Nilgiritragus hylocrius",
                    "High-altitude montane shola grasslands, rugged cliffs",
                    "Eravikulam National Park, Nilgiri Hills, Anamalai",
                    "The Nilgiri Tahr is a stocky wild mountain goat endemic to the high crests of the Western Ghats. Its rubbery curved hooves provide incredible grip on near-vertical granite cliffs overlooking misty mountain valleys.",
                    "tahrgallery.jpg"
                },
                {
                    "Kashmir Stag (Hangul)",
                    "Animal",
                    "Cervus hanglu hanglu",
                    "Dense riverine valleys, temperate mixed forests, alpine meadows",
                    "Dachigam National Park, Jammu & Kashmir",
                    "The Hangul is a critically endangered subspecies of red deer native solely to the Kashmir Valley. Males are famed for their majestic multi-pointed antlers, and conservation efforts are vital to secure their Himalayan habitat.",
                    "staggallery.jpg"
                },
                {
                    "Indian Wild Ass (Khur)",
                    "Animal",
                    "Equus hemionus khur",
                    "Salt-encrusted desert mudflats, saline scrub plains",
                    "Little Rann of Kutch Wildlife Sanctuary, Gujarat",
                    "The Indian Wild Ass is a remarkably resilient desert equid capable of sprinting at 50 km/h across the sun-baked salt plains of Gujarat. Its sandy coat and white underbelly reflect the harsh desert sun.",
                    "wildass.jpg"
                },
                {
                    "Spotted Deer (Chital)",
                    "Animal",
                    "Axis axis",
                    "Dry and moist deciduous woodlands, open forest clearings",
                    "Kanha, Jim Corbett, Nagarhole, Bandipur, Sundarbans",
                    "The Chital or Spotted Deer is one of India's most graceful herbivores, adorned with a rufous coat dotted with permanent white spots. It shares a famous cooperative relationship with langurs, who drop fruit and sound warning calls from the canopy.",
                    "deer.jpg"
                },
                {
                    "Snow Leopard",
                    "Animal",
                    "Panthera uncia",
                    "Alpine scree, rugged cliffs above tree line, glacial valleys",
                    "Hemis National Park (Ladakh), Spiti Valley, Great Himalayan NP",
                    "Known as the 'Ghost of the Mountains', the Snow Leopard is an elusive feline built for the extreme cold of the Himalayas. Its wide paws act as natural snowshoes, and its thick tail provides balance along precarious ridgelines.",
                    "snowleopard.jpg"
                },
                {
                    "Red Panda",
                    "Animal",
                    "Ailurus fulgens",
                    "Temperate mixed broadleaf and conifer forests with bamboo understory",
                    "Singalila National Park, Neora Valley, Namdapha (Arunachal)",
                    "The Red Panda is an adorable tree-dwelling mammal of the Eastern Himalayas. Recognized by its reddish-brown fur, striped tail, and specialized false thumb, it feeds almost entirely on fresh bamboo shoots.",
                    "redpanda.jpg"
                },
                {
                    "Indian Sloth Bear",
                    "Animal",
                    "Melursus ursinus",
                    "Dry deciduous forests, scrublands, rocky caves",
                    "Daroji Sloth Bear Sanctuary, Satpura, Ranthambore",
                    "The Sloth Bear is a shaggy, nocturnal insectivore known for its distinctive white Y-shaped chest marking, long snout, and curved claws designed for digging open termite mounds.",
                    "slothbear.jpg"
                },

                // Birds of India
                {
                    "Great Indian Hornbill",
                    "Bird",
                    "Buceros bicornis",
                    "Dense primary rainforests, towering emergent canopy trees",
                    "Western Ghats, Kaziranga, Namdapha, Dandeli",
                    "The Great Indian Hornbill is an iconic forest bird sporting a prominent golden-yellow casque atop its curved beak. The heavy flap of its expansive wings produces a distinctive rushing roar through the rainforest canopy.",
                    "hornbill.jpg"
                },
                {
                    "Indian Peafowl (Peacock)",
                    "Bird",
                    "Pavo cristatus",
                    "Deciduous forests, open riparian woodlands, scrub margins",
                    "Widely found across Indian states; Rajasthan, Gujarat, MP",
                    "The National Bird of India, celebrated worldwide for the male's iridescent sapphire-blue plumage and spectacular fan of eye-spotted iridescent train feathers displayed in joyful courtship dances during the monsoons.",
                    "peacock.jpg"
                },
                {
                    "Rose-ringed Parakeet",
                    "Bird",
                    "Psittacula krameri",
                    "Deciduous woodlands, river valleys, gardens, urban groves",
                    "Widespread throughout peninsular and northern India",
                    "A vibrant emerald-green parakeet featuring a curved red hooked bill and long graduated tail. Adult males sport a delicate rose-pink and black neck ring, and flocks are famous for their lively, cheerful calls.",
                    "parakeet.jpg"
                },
                {
                    "Malabar Pied Hornbill",
                    "Bird",
                    "Anthracoceros coronatus",
                    "Moist deciduous and evergreen coastal forest belts",
                    "Dandeli, Western Ghats, Simlipal, Central India",
                    "A large, intelligent canopy hornbill with striking pied black-and-white plumage and a massive pale-yellow casque. It plays a critical role in forest regeneration by dispersing large fruit seeds over long distances.",
                    "hornbillgallery.jpg"
                },
                {
                    "Sarus Crane",
                    "Bird",
                    "Antigone antigone",
                    "Freshwater marshes, floodplains, inundated paddy fields",
                    "Keoladeo National Park, Uttar Pradesh, Gujarat",
                    "The Sarus Crane is the world's tallest flying bird, standing nearly 6 feet high. Renowned for its velvety grey plumage, crimson-red head, and lifelong monogamous bonding celebrated in classical Indian folklore.",
                    "saruscrane.jpg"
                },
                {
                    "Himalayan Monal",
                    "Bird",
                    "Lophophorus impejanus",
                    "High-elevation oak-rhododendron forests, alpine meadows",
                    "Great Himalayan NP, Kedarnath Wildlife Sanctuary, Sikkim",
                    "The state bird of Uttarakhand, the Himalayan Monal pheasant is celebrated for the male's dazzling iridescent rainbow plumage that shimmers with metallic greens, blues, purples, and coppers under Himalayan sunlight.",
                    "monal.jpg"
                },
                {
                    "Indian Roller (Blue Jay)",
                    "Bird",
                    "Coracias benghalensis",
                    "Open scrublands, agricultural fields, light forest edges",
                    "Widespread throughout India; State bird of Karnataka and Odisha",
                    "Famous for its acrobatic aerial rolls during courtship, the Indian Roller reveals flashes of breathtaking turquoise and electric blue flight feathers when in flight, held sacred in traditional folklore.",
                    "indianroller.jpg"
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
            System.out.println("Animals & Birds successfully seeded: " + animals.length);

            System.out.println("Oracle Database completely updated with properly matched images!");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (Exception ignored) {}
            }
        }
    }
}
