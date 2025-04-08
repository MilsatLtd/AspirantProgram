import instagram from "../Assets/instagram.svg";
import linkedin from "../Assets/linkedin.svg";
import twitter from "../Assets/twitter.svg";
import dataCollectionImage from "../Assets/data_collection.jpg";
import community from "../Assets/community-picture.jpg";
import designer from "../Assets/designer-picture.jpeg";
import gisEnterprise from "../Assets/gis-enterprise.png";
import triangleBlue from "../Assets/triangleTexture-blue.svg";
import triangleGreen from "../Assets/triangleTexture-green.svg";
import trianglePurple from "../Assets/triangleTexture-purple.svg";
import globe from "../Assets/globe.svg";
import rocket from "../Assets/rocket.svg";
import planet from "../Assets/planetIcon.svg";
import esriLogo from "../Assets/partners-logo/esri.svg";

export const routes = {
  navLinks: [
    {
      id: 1,
      name: "Home",
      link: "/",
    },
    {
      id: 2,
      name: "Explore",
      link: "/explore",
    },
    // {
    //     id:3,
    //     name: 'About',
    //     link: '/about'
    // },
    {
      id: 4,
      name: "FAQs",
      link: "/faqs",
    },
  ],
  quickLinks: [
    {
      id: 1,
      name: "Application Here",
      link: "/apply",
    },
    {
      id: 1,
      name: "Terms and Conditions",
      link: "apply/T&C",
    },
  ],
  tracks: [
    {
      id: 1,
      name: "Data Collection and Field Mapping",
      link: "/track/data-collection-and-field-mapping",
    },
    {
      id: 2,
      name: "Fundamental of GIS",
      link: "/track/fundamental-of-gis",
    },
    {
      id: 3,
      name: "Geospatial Enterprise Solution",
      link: "/track/geospatial-enterprise-solution",
    },
  ],
};

export const bottomline = [
  {
    bg_color: "#2BBDB2",
  },
  {
    bg_color: "#B58BB8",
  },
  {
    bg_color: "#383639",
  },
  {
    bg_color: "#2BBDB2",
  },
  {
    bg_color: "#B58BB8",
  },
  {
    bg_color: "#383639",
  },
  {
    bg_color: "#2BBDB2",
  },
  {
    bg_color: "#B58BB8",
  },
  {
    bg_color: "#383639",
  },
];

export const socialMediaIcon = [
  {
    id: 1,
    icon: linkedin,
    name: "linkedin-icon",
    link: "https://www.linkedin.com/company/milsat",
  },
  {
    id: 2,
    icon: instagram,
    name: "instagram-icon",
    link: "https://www.instagram.com/insidemilsat/",
  },

  {
    id: 3,
    icon: twitter,
    name: "twitter-icon",
    link: "https://twitter.com/milsat_africa",
  },
];

export const eligibility = [
  {
    id: 1,
    criteria: "Basic computer skills",
  },
  {
    id: 2,
    criteria: "Access to a computer with internet connectivity",
  },
];

export const AvailableTracks = [
  {
    id: "data-collection-and-field-mapping",
    trackName: "Data Collection and Field Mapping",
    description:
      "Designed to equip participants with the essential skills and knowledge needed for effective field data collection, spatial analysis, and utilizing cutting-edge data collection technologies",
    startDate: "23rd August, 2024",
    endDate: "14th September, 2024",
    learningTimeLine: "2 weeks",
    TrackInfo: [
      {
        name: "Track-curriculum",
        list: [
          {
            id: 1,
            criteria: "Introduction to Data Collection and Field Mapping",
          },
          {
            id: 2,
            criteria: "Guide to Field Data Collection",
          },
          {
            id: 3,
            criteria: "Satellite Image Interpretation",
          },
          {
            id: 4,
            criteria: "Technology (Field Devices) Field Practical",
          },
          {
            id: 5,
            criteria: "Milsat Enumeration Network",
          },
          {
            id: 6,
            criteria: "Guidelines for the Milsat Mapper Network",
          },
          {
            id: 7,
            criteria: "Mappers Network Peculiarities",
          },
        ],
      },
      {
        name: "Track Requirement",
        list: [
          {
            id: 1,
            criteria:
              "You need A mobile device (Android Version 10.0 and Above)",
          },
          {
            id: 2,
            criteria: "Access to internet connectivity.",
          },
          {
            id: 3,
            criteria: "Understanding of geographic concept",
          },
        ],
      },
    ],
  },
  {
    id: "fundamental-of-gis",
    trackName: "Fundamental of GIS",
    description:
      "Explore the foundational principles and essential skills of Geographic Information Systems (GIS) in this beginner-friendly track, gaining a solid understanding of the system",
    startDate: "23rd August, 2024",
    endDate: "14th September, 2024",
    learningTimeLine: "2 weeks",
    TrackInfo: [
      {
        name: "Track-curriculum",
        list: [
          {
            id: 1,
            criteria: "Introduction to Geographic Information System (GIS)",
          },
          {
            id: 2,
            criteria: "Setting Up your GIS software",
          },
          {
            id: 3,
            criteria: "Coordinate system and Georeferencing in GIS",
          },
          {
            id: 4,
            criteria: "Basic Geoprocessing tools",
          },
          {
            id: 5,
            criteria: "Querying in GIS",
          },
          {
            id: 6,
            criteria: "Cartography and map design",
          },
        ],
      },
      {
        name: "Track Requirement",
        list: [
          {
            id: 1,
            criteria:
              "You will need a mouse and a computer, to install QGIS or ArcMap and a willing mind to learn!",
          },
        ],
      },
    ],
  },
  {
    id: "geospatial-enterprise-solution",
    trackName: "Geospatial Enterprise Solution",
    description:
      "This course covers geospatial software, including both open-source and commercial tools. Participants will grasp the significance and advantages of using these tools for effective spatial analysis and decision-making",
    startDate: "",
    endDate: "",
    learningTimeLine: "5 weeks",
    TrackInfo: [
      {
        name: "Track-curriculum",
        list: [
          {
            id: 1,
            criteria: "Overview of Geospatial Software and Tools",
          },
          {
            id: 2,
            criteria: "Understanding Client Project Specifications",
          },
          {
            id: 3,
            criteria: "Deployment of Geospatial Tools",
          },
          {
            id: 4,
            criteria: "Activating and licensing of software",
          },
        ],
      },
      {
        name: "Track Requirement",
        list: [
          {
            id: 1,
            criteria:
              "You need a Personal Computer (PC) with “Configuration: 8 GB RAM, storage: 500 GB and Above” clickhere to View a complete system configuration",
          },
          {
            id: 2,
            criteria: "Access to internet connectivity.",
          },
          {
            id: 3,
            criteria: "Must have complete Fundamental of GIS track",
          },
        ],
      },
    ],
  },
];

export const applictionTimeline = {
  startDate: "23rd August, 2024",
  endDate: "14th September, 2024",
};

export const termsAndConditions = {
  firstTerms:
    "I hereby declare that all information provided are accurate and complete",
  secondTerms:
    "I hereby declare that I have read and understood the terms and conditions of the Milsat Aspirant Programme (MAP) and agree to abide by them.",
};

export const ProgrammeFeatures = {
  title: "How it works ?",
  howItWorks: [
    {
      id: 1,
      title: "Choose a track",
      description:
        "Explore our range of courses and choose your preferred track that aligns with your goals and leverages your unique strength.",
    },
    {
      id: 2,
      title: "Kickstart your GIS journey",
      description:
        "Work through your track in your own time, whenever and wherever suits you. All you need is access to the internet and a device to learn on.",
    },
    {
      id: 3,
      title: "Be job ready",
      description:
        "Prove your new skills with a professional accreditation and take the next step in your career or academic journey.",
    },
  ],
  featuresIcon: {
    rocket: rocket,
    globe: globe,
    planet: planet,
  },
};

export const TrackCardsInfo = [
  {
    id: 2,
    name: "Data Collection and Field Mapping",
    picture: dataCollectionImage,
    route: "/track/data-collection-and-field-mapping",
  },
  {
    id: 1,
    name: "Fundamental of GIS",
    picture: community,
    route: "/track/fundamental-of-gis",
  },
  {
    id: 3,
    name: "Geospatial Enterprise Solution",
    picture: gisEnterprise,
    route: "/track/geospatial-enterprise-solution",
  },
];

export const knowledgeInfo = {
  title: "Transform your passion into proficiency",
  description:
    "From fundamentals to advanced techniques, our courses are structured to help you stay ahead of the curve and reach remarkable milestones in your GIS career.",
};

export const ChortMessages = [
  {
    id: 1,
    title: "Access to Cutting-Edge GIS Tools",
    message:
      "Gain access to  the most up-to-date software and advanced technology to equip yourself for a transformative learning experience.",
    color: "#007A71",
    texture: triangleGreen,
  },
  {
    id: 2,
    title: "Gain Hands-On Experience",
    message:
      "Work on practical projects that allows you to apply your GIS skills and get acquainted with industry-standards in a practical learning environment.",
    color: "#5A275D",
    texture: trianglePurple,
  },
  {
    id: 3,
    title: "Connect with Peers",
    message:
      "Engage, network and collaborate with a supportive community of fellow GIS enthusiasts and learners.",
    color: "#312987",
    texture: triangleBlue,
  },
  {
    id: 4,
    title: "Learn from Experienced Professionals",
    message:
      "Gain valuable insights into the GIS industry, its applications, and future developments from experts in the field.",
    color: "#312987",
    texture: triangleBlue,
  },
  {
    id: 5,
    title: "Earn a Certificate",
    message:
      "Validate your skills and knowledge in GIS through our certification programs.",
    color: "#007A71",
    texture: triangleGreen,
  },
  {
    id: 6,
    title: "Unlock career opportunities",
    message:
      "Discover the multitude of career avenues available in the GIS job market.",
    color: "#5A275D",
    texture: trianglePurple,
  },
];

export const Partners = [
  {
    id: 1,
    name: "Esri",
    logo: esriLogo,
  },
];

export const Faqs = [
  {
    id: 1,
    faqTitle: "About the program",
    faqList: [
      {
        id: 1,
        question: "What is M.A.P?",
        answer:
          "The Milsat Aspirant Programme (MAP) is crafted to enable individuals with aspirations to acquire knowledge, foster personal development, and excel in the ever-evolving geospatial industry.",
      },
      {
        id: 2,
        question: "What background knowledge is necessary?",
        answer:
          "No particular prior experience is necessary; this Specialization is well-suited for individuals with a focus on GIS or anyone looking to gain a competitive advantage in the evolving field of GIS.",
      },
      {
        id: 3,
        question:
          "Is this course really 100% online, do I need to attend any classes in person?",
        answer:
          "This course is completely online, so there’s no need to show up to a classroom in person. You have the flexibility to reach your lectures, readings, and assignments at your convenience, whether through the web or on your mobile device, from any location.",
      },
    ],
  },
];

export const MobileFeatures = [
  {
    id: 1,
    description: "Interactive learning environment",
  },
  {
    id: 2,
    description: "Customized GIS proficiency",
  },
  {
    id: 3,
    description: "Personalized Support",
  },
];

export const oppourtunity = [
  {
    id: 1,
    title: "What you stand to gain",
    oppourtunityList: [
      {
        id: 1,
        description: "You become our first contact for job opportunity",
      },
      {
        id: 2,
        description:
          "Be job ready and add value to the society with your skill",
      },
    ],
  },
];

export const africanCountries = [
  { label: "Algeria", value: "Algeria" },
  { label: "Angola", value: "Angola" },
  { label: "Benin", value: "Benin" },
  { label: "Botswana", value: "Botswana" },
  { label: "Burkina Faso", value: "Burkina Faso" },
  { label: "Burundi", value: "Burundi" },
  { label: "Cabo Verde", value: "Cabo Verde" },
  { label: "Cameroon", value: "Cameroon" },
  { label: "Central African Republic", value: "Central African Republic" },
  { label: "Chad", value: "Chad" },
  { label: "Comoros", value: "Comoros" },
  {
    label: "Democratic Republic of the Congo",
    value: "Democratic Republic of the Congo",
  },
  { label: "Republic of the Congo", value: "Republic of the Congo" },
  { label: "Djibouti", value: "Djibouti" },
  { label: "Egypt", value: "Egypt" },
  { label: "Equatorial Guinea", value: "Equatorial Guinea" },
  { label: "Eritrea", value: "Eritrea" },
  { label: "Eswatini", value: "Eswatini" },
  { label: "Ethiopia", value: "Ethiopia" },
  { label: "Gabon", value: "Gabon" },
  { label: "Gambia", value: "Gambia" },
  { label: "Ghana", value: "Ghana" },
  { label: "Guinea", value: "Guinea" },
  { label: "Guinea-Bissau", value: "Guinea-Bissau" },
  { label: "Ivory Coast", value: "Ivory Coast" },
  { label: "Kenya", value: "Kenya" },
  { label: "Lesotho", value: "Lesotho" },
  { label: "Liberia", value: "Liberia" },
  { label: "Libya", value: "Libya" },
  { label: "Madagascar", value: "Madagascar" },
  { label: "Malawi", value: "Malawi" },
  { label: "Mali", value: "Mali" },
  { label: "Mauritania", value: "Mauritania" },
  { label: "Mauritius", value: "Mauritius" },
  { label: "Morocco", value: "Morocco" },
  { label: "Mozambique", value: "Mozambique" },
  { label: "Namibia", value: "Namibia" },
  { label: "Niger", value: "Niger" },
  { label: "Nigeria", value: "Nigeria" },
  { label: "Rwanda", value: "Rwanda" },
  { label: "Sao Tome and Principe", value: "Sao Tome and Principe" },
  { label: "Senegal", value: "Senegal" },
  { label: "Seychelles", value: "Seychelles" },
  { label: "Sierra Leone", value: "Sierra Leone" },
  { label: "Somalia", value: "Somalia" },
  { label: "South Africa", value: "South Africa" },
  { label: "South Sudan", value: "South Sudan" },
  { label: "Sudan", value: "Sudan" },
  { label: "Tanzania", value: "Tanzania" },
  { label: "Togo", value: "Togo" },
  { label: "Tunisia", value: "Tunisia" },
  { label: "Uganda", value: "Uganda" },
  { label: "Zambia", value: "Zambia" },
  { label: "Zimbabwe", value: "Zimbabwe" },
];

export const nigerianStatesAndLGAs = [
  {
      "name": "Abia",
      "lgas": [
          "Aba North",
          "Aba South",
          "Arochukwu",
          "Bende",
          "Ikwuano",
          "Isiala-Ngwa North",
          "Isiala-Ngwa South",
          "Isuikwato",
          "Obingwa",
          "Ohafia",
          "Osisioma",
          "Ugwunagbo",
          "Ukwa East",
          "Ukwa West",
          "Umuahia North",
          "Umuahia South",
          "Umu-Nnochi"
      ]
  },
  {
      "name": "Adamawa",
      "lgas": [
          "Demsa",
          "Fufore",
          "Ganaye",
          "Gireri",
          "Gombi",
          "Guyuk",
          "Hong",
          "Jada",
          "Lamurde",
          "Madagali",
          "Maiha",
          "Mayo-Belwa",
          "Michika",
          "Mubi North",
          "Mubi South",
          "Numan",
          "Shelleng",
          "Song",
          "Toungo",
          "Yola North",
          "Yola South"
      ]
  },
  {
      "name": "Akwa-Ibom",
      "lgas": [
          "Abak",
          "Eastern Obolo",
          "Eket",
          "Esit Eket",
          "Essien Udim",
          "Etim Ekpo",
          "Etinan",
          "Ibeno",
          "Ibesikpo Asutan",
          "Ibiono Ibom",
          "Ika",
          "Ikono",
          "Ikot Abasi",
          "Ikot Ekpene",
          "Ini",
          "Itu",
          "Mbo",
          "Mkpat Enin",
          "Nsit Atai",
          "Nsit Ibom",
          "Nsit Ubium",
          "Obot Akara",
          "Okobo",
          "Onna",
          "Oron",
          "Oruk Anam",
          "Udung Uko",
          "Ukanafun",
          "Uruan",
          "Urue-Offong/Oruko",
          "Uyo"
      ]
  },
  {
      "name": "Anambra",
      "lgas": [
          "Aguata",
          "Anambra East",
          "Anambra West",
          "Anaocha",
          "Awka North",
          "Awka South",
          "Ayamelum",
          "Dunukofia",
          "Ekwusigo",
          "Idemili North",
          "Idemili south",
          "Ihiala",
          "Njikoka",
          "Nnewi North",
          "Nnewi South",
          "Ogbaru",
          "Onitsha North",
          "Onitsha South",
          "Orumba North",
          "Orumba South",
          "Oyi"
      ]
  },
  {
      "name": "Bauchi",
      "lgas": [
          "Alkaleri",
          "Bauchi",
          "Bogoro",
          "Damban",
          "Darazo",
          "Dass",
          "Ganjuwa",
          "Giade",
          "Itas/Gadau",
          "Jama'are",
          "Katagum",
          "Kirfi",
          "Misau",
          "Ningi",
          "Shira",
          "Tafawa-Balewa",
          "Toro",
          "Warji",
          "Zaki"
      ]
  },
  {
      "name": "Bayelsa",
      "lgas": [
          "Brass",
          "Ekeremor",
          "Kolokuma/Opokuma",
          "Nembe\tOgbia",
          "Sagbama",
          "Southern Jaw",
          "Yenegoa"
      ]
  },
  {
      "name": "Benue",
      "lgas": [
          "Ado",
          "Agatu",
          "Apa",
          "Buruku",
          "Gboko",
          "Guma",
          "Gwer East",
          "Gwer West",
          "Katsina-Ala",
          "Konshisha",
          "Kwande",
          "Logo",
          "Makurdi",
          "Obi",
          "Ogbadibo",
          "Oju",
          "Okpokwu",
          "Ohimini",
          "Oturkpo",
          "Tarka",
          "Ukum",
          "Ushongo",
          "Vandeikya"
      ]
  },
  {
      "name": "Borno",
      "lgas": [
          "Abadam",
          "Askira/Uba",
          "Bama",
          "Bayo",
          "Biu",
          "Chibok",
          "Damboa",
          "Dikwa",
          "Gubio",
          "Guzamala",
          "Gwoza",
          "Hawul",
          "Jere",
          "Kaga",
          "Kala/Balge",
          "Konduga",
          "Kukawa",
          "Kwaya Kusar",
          "Mafa",
          "Magumeri",
          "Maiduguri",
          "Marte",
          "Mobbar",
          "Monguno",
          "Ngala",
          "Nganzai",
          "Shani"
      ]
  },
  {
      "name": "Cross-River",
      "lgas": [
          "Akpabuyo",
          "Odukpani",
          "Akamkpa",
          "Biase",
          "Abi",
          "Ikom",
          "Yarkur",
          "Odubra",
          "Boki",
          "Ogoja",
          "Yala",
          "Obanliku",
          "Obudu",
          "Calabar South",
          "Etung",
          "Bekwara",
          "Bakassi",
          "Calabar Municipality"
      ]
  },
  {
      "name": "Delta",
      "lgas": [
          "Oshimili",
          "Aniocha",
          "Aniocha South",
          "Ika South",
          "Ika North-East",
          "Ndokwa West",
          "Ndokwa East",
          "Isoko south",
          "Isoko North",
          "Bomadi",
          "Burutu",
          "Ughelli South",
          "Ughelli North",
          "Ethiope West",
          "Ethiope East",
          "Sapele",
          "Okpe",
          "Warri North",
          "Warri South",
          "Uvwie",
          "Udu",
          "Warri Central",
          "Ukwani",
          "Oshimili North",
          "Patani"
      ]
  },
  {
      "name": "Ebonyi",
      "lgas": [
          "Abakaliki",
          "Afikpo South",
          "Afikpo North",
          "Onicha",
          "Ohaozara",
          "Ishielu",
          "lkwo",
          "Ezza",
          "Ezza South",
          "Ohaukwu",
          "Ebonyi",
          "Ivo"
      ]
  },
  {
      "name": "Edo",
      "lgas": [
          "Esan North-East",
          "Esan Central",
          "Esan West",
          "Egor",
          "Ukpoba Central",
          "Etsako Central",
          "Igueben",
          "Oredo",
          "Ovia SouthWest",
          "Ovia South-East",
          "Orhionwon",
          "Uhunmwonde",
          "Etsako East",
          "Esan South-East"
      ]
  },
  {
      "name": "Ekiti",
      "lgas": [
          "Ado",
          "Ekiti-East",
          "Ekiti-West",
          "Emure/Ise/Orun",
          "Ekiti South-West",
          "Ikare",
          "Irepodun",
          "Ijero",
          "Ido/Osi",
          "Oye",
          "Ikole",
          "Moba",
          "Gbonyin",
          "Efon",
          "Ise/Orun",
          "Ilejemeje"
      ]
  },
  {
      "name": "Enugu",
      "lgas": [
          "Enugu South",
          "Igbo-Eze South",
          "Enugu North",
          "Nkanu",
          "Udi Agwu",
          "Oji-River",
          "Ezeagu",
          "IgboEze North",
          "Isi-Uzo",
          "Nsukka",
          "Igbo-Ekiti",
          "Uzo-Uwani",
          "Enugu East",
          "Aninri",
          "Nkanu East",
          "Udenu"
      ]
  },
  {
      "name": "Gombe",
      "lgas": [
          "Akko",
          "Balanga",
          "Billiri",
          "Dukku",
          "Kaltungo",
          "Kwami",
          "Shomgom",
          "Funakaye",
          "Gombe",
          "Nafada/Bajoga",
          "Yamaltu/Delta"
      ]
  },
  {
      "name": "Imo",
      "lgas": [
          "Aboh-Mbaise",
          "Ahiazu-Mbaise",
          "Ehime-Mbano",
          "Ezinihitte",
          "Ideato North",
          "Ideato South",
          "Ihitte/Uboma",
          "Ikeduru",
          "Isiala Mbano",
          "Isu",
          "Mbaitoli",
          "Ngor-Okpala",
          "Njaba",
          "Nwangele",
          "Nkwerre",
          "Obowo",
          "Oguta",
          "Ohaji/Egbema",
          "Okigwe",
          "Orlu",
          "Orsu",
          "Oru East",
          "Oru West",
          "Owerri-Municipal",
          "Owerri North",
          "Owerri West"
      ]
  },
  {
      "name": "Jigawa",
      "lgas": ["Auyo", "Babura", "Birni Kudu", "Biriniwa", "Buji", "Dutse", "Gagarawa", "Garki", "Gumel", "Guri", "Gwaram", "Gwiwa", "Hadejia", "Jahun", "Kafin Hausa", "Kaugama Kazaure", "Kiri Kasamma", "Kiyawa", "Maigatari", "Malam Madori", "Miga", "Ringim", "Roni", "Sule-Tankarkar", "Taura", "Yankwashi"]
  },
  {
      "name": "Kaduna",
      "lgas": ["Birni-Gwari", "Chikun", "Giwa", "Igabi", "Ikara", "Jaba", "Jema'a", "Kachia", "Kaduna North", "Kaduna South", "Kagarko", "Kajuru", "Kaura", "Kauru", "Kubau", "Kudan", "Lere", "Makarfi", "Sabon-Gari", "Sanga", "Soba", "Zango-Kataf", "Zaria"]
  },
  {
      "name": "Kano",
      "lgas": ["Ajingi", "Albasu", "Bagwai", "Bebeji", "Bichi", "Bunkure", "Dala", "Dambatta", "Dawakin Kudu", "Dawakin Tofa", "Doguwa", "Fagge", "Gabasawa", "Garko", "Garum", "Mallam", "Gaya", "Gezawa", "Gwale", "Gwarzo", "Kabo", "Kano Municipal", "Karaye", "Kibiya", "Kiru", "kumbotso", "Kunchi", "Kura", "Madobi", "Makoda", "Minjibir", "Nasarawa", "Rano", "Rimin Gado", "Rogo", "Shanono", "Sumaila", "Takali", "Tarauni", "Tofa", "Tsanyawa", "Tudun Wada", "Ungogo", "Warawa", "Wudil"]
  },
  {
      "name": "Katsina",
      "lgas": ["Bakori", "Batagarawa", "Batsari", "Baure", "Bindawa", "Charanchi", "Dandume", "Danja", "Dan Musa", "Daura", "Dutsi", "Dutsin-Ma", "Faskari", "Funtua", "Ingawa", "Jibia", "Kafur", "Kaita", "Kankara", "Kankia", "Katsina", "Kurfi", "Kusada", "Mai'Adua", "Malumfashi", "Mani", "Mashi", "Matazuu", "Musawa", "Rimi", "Sabuwa", "Safana", "Sandamu", "Zango"]
  },
  {
      "name": "Kebbi",
      "lgas": ["Aleiro", "Arewa-Dandi", "Argungu", "Augie", "Bagudo", "Birnin Kebbi", "Bunza", "Dandi", "Fakai", "Gwandu", "Jega", "Kalgo", "Koko/Besse", "Maiyama", "Ngaski", "Sakaba", "Shanga", "Suru", "Wasagu/Danko", "Yauri", "Zuru"]
  },
  {
      "name": "Kogi",
      "lgas": ["Adavi", "Ajaokuta", "Ankpa", "Bassa", "Dekina", "Ibaji", "Idah", "Igalamela-Odolu", "Ijumu", "Kabba/Bunu", "Kogi", "Lokoja", "Mopa-Muro", "Ofu", "Ogori/Mangongo", "Okehi", "Okene", "Olamabolo", "Omala", "Yagba East", "Yagba West"]
  },
  {
      "name": "Kwara",
      "lgas": ["Asa", "Baruten", "Edu", "Ekiti", "Ifelodun", "Ilorin East", "Ilorin West", "Irepodun", "Isin", "Kaiama", "Moro", "Offa", "Oke-Ero", "Oyun", "Pategi"]
  },
  {
      "name": "Lagos",
      "lgas": ["Agege", "Ajeromi-Ifelodun", "Alimosho", "Amuwo-Odofin", "Apapa", "Badagry", "Epe", "Eti-Osa", "Ibeju/Lekki", "Ifako-Ijaye", "Ikeja", "Ikorodu", "Kosofe", "Lagos Island", "Lagos Mainland", "Mushin", "Ojo", "Oshodi-Isolo", "Shomolu", "Surulere"]
  },
  {
      "name": "Nasarawa",
      "lgas": ["Akwanga", "Awe", "Doma", "Karu", "Keana", "Keffi", "Kokona", "Lafia", "Nasarawa", "Nasarawa-Eggon", "Obi", "Toto", "Wamba"]
  },
  {
      "name": "Niger",
      "lgas": ["Agaie", "Agwara", "Bida", "Borgu", "Bosso", "Chanchaga", "Edati", "Gbako", "Gurara", "Katcha", "Kontagora", "Lapai", "Lavun", "Magama", "Mariga", "Mashegu", "Mokwa", "Muya", "Pailoro", "Rafi", "Rijau", "Shiroro", "Suleja", "Tafa", "Wushishi"]
  },
  {
      "name": "Ogun",
      "lgas": ["Abeokuta North", "Abeokuta South", "Ado-Odo/Ota", "Egbado North", "Egbado South", "Ewekoro", "Ifo", "Ijebu East", "Ijebu North", "Ijebu North East", "Ijebu Ode", "Ikenne", "Imeko-Afon", "Ipokia", "Obafemi-Owode", "Ogun Waterside", "Odeda", "Odogbolu", "Remo North", "Shagamu"]
  },
  {
      "name": "Ondo",
      "lgas": ["Akoko North East", "Akoko North West", "Akoko South Akure East", "Akoko South West", "Akure North", "Akure South", "Ese-Odo", "Idanre", "Ifedore", "Ilaje", "Ile-Oluji", "Okeigbo", "Irele", "Odigbo", "Okitipupa", "Ondo East", "Ondo West", "Ose", "Owo"]
  },
  {
      "name": "Osun",
      "lgas": ["Aiyedade", "Aiyedire", "Atakumosa East", "Atakumosa West", "Boluwaduro", "Boripe", "Ede North", "Ede South", "Egbedore", "Ejigbo", "Ife Central", "Ife East", "Ife North", "Ife South", "Ifedayo", "Ifelodun", "Ila", "Ilesha East", "Ilesha West", "Irepodun", "Irewole", "Isokan", "Iwo", "Obokun", "Odo-Otin", "Ola-Oluwa", "Olorunda", "Oriade", "Orolu", "Osogbo"]
  },
  {
      "name": "Oyo",
      "lgas": ["Afijio", "Akinyele", "Atiba", "Atigbo", "Egbeda", "IbadanCentral", "Ibadan North", "Ibadan North West", "Ibadan South East", "Ibadan South West", "Ibarapa Central", "Ibarapa East", "Ibarapa North", "Ido", "Irepo", "Iseyin", "Itesiwaju", "Iwajowa", "Kajola", "Lagelu Ogbomosho North", "Ogbmosho South", "Ogo Oluwa", "Olorunsogo", "Oluyole", "Ona-Ara", "Orelope", "Ori Ire", "Oyo East", "Oyo West", "Saki East", "Saki West", "Surulere"]
  },
  {
      "name": "Plateau",
      "lgas": ["Barikin Ladi", "Bassa", "Bokkos", "Jos East", "Jos North", "Jos South", "Kanam", "Kanke", "Langtang North", "Langtang South", "Mangu", "Mikang", "Pankshin", "Qua'an Pan", "Riyom", "Shendam", "Wase"]
  },
  {
      "name": "Rivers",
      "lgas": ["Abua/Odual", "Ahoada East", "Ahoada West", "Akuku Toru", "Andoni", "Asari-Toru", "Bonny", "Degema", "Emohua", "Eleme", "Etche", "Gokana", "Ikwerre", "Khana", "Obia/Akpor", "Ogba/Egbema/Ndoni", "Ogu/Bolo", "Okrika", "Omumma", "Opobo/Nkoro", "Oyigbo", "Port-Harcourt", "Tai"]
  },
  {
      "name": "Sokoto",
      "lgas": ["Binji", "Bodinga", "Dange-shnsi", "Gada", "Goronyo", "Gudu", "Gawabawa", "Illela", "Isa", "Kware", "kebbe", "Rabah", "Sabon birni", "Shagari", "Silame", "Sokoto North", "Sokoto South", "Tambuwal", "Tungaza", "Tureta", "Wamako", "Wurno", "Yabo"]
  },
  {
      "name": "Taraba",
      "lgas": ["Ardo-kola", "Bali", "Donga", "Gashaka", "Cassol", "Ibi", "Jalingo", "Karin-Lamido", "Kurmi", "Lau", "Sardauna", "Takum", "Ussa", "Wukari", "Yorro", "Zing"]
  },
  {
      "name": "Yobe",
      "lgas": ["Bade", "Bursari", "Damaturu", "Fika", "Fune", "Geidam", "Gujba", "Gulani", "Jakusko", "Karasuwa", "Karawa", "Machina", "Nangere", "Nguru Potiskum", "Tarmua", "Yunusari", "Yusufari"]
  },
  {
      "name": "Zamfara",
      "lgas": ["Anka", "Bakura", "Birnin Magaji", "Bukkuyum", "Bungudu", "Gummi", "Gusau", "Kaura", "Namoda", "Maradun", "Maru", "Shinkafi", "Talata Mafara", "Tsafe", "Zurmi"]
  }
]
export const Brochure = {
  FundamentalOfGIS: "/Fundamental_of_GIS.pdf",
  DataCollectionAndFieldMapping: "/Data_Collection_and_Field_Mapping.pdf",
  GeospatialEnterpriseSolution: "/Geospatial_Enterprise_Solution.pdf",
};

export const MobileAppPlayStoreLink =
  "https://play.google.com/store/apps/details?id=com.milsat.apirant&pcampaignid=web_share";

export const ApplicationEmailTemplate = `<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Application Received</title>
<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
  }

  .container {
    max-width: 600px;
    margin: 20px auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }

  h1 {
    color: #333;
  }

  p {
    color: #666;
  }

  .cta-button {
    display: inline-block;
    padding: 10px 20px;
    background-color: #3498db;
    color: #fff;
    text-decoration: none;
    border-radius: 5px;
  }
  
  .footer {
    margin-top: 30px;
    text-align: center;
    color: #888;
  }
</style>
</head>
<body>
<div class="container">
  <p>We have successfully received your application for the Milsat Aspirant Program. Your submission is currently under review and you'll be notified via email upon approval.</p>
  <p>Your application is now under review.</p>
  <p>If you have any questions or concerns, please feel free to reach out to us at <a href="mailto:map.milsat@gmail.com">support</a></p> 
  <p>Best regards,</p>
  <p class="footer">This is an automated email, please do not reply.</p>
</div>
</body>
</html>
`;
