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
      name: "Geospatial Data Collection & GIS for Professionals",
      link: "/track/geospatial-data-collection-and-gis-for-professionals",
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
    id: "geospatial-data-collection-and-gis-for-professionals",
    trackName: "Geospatial Data Collection & GIS for Professionals",
    description:
      "Designed to equip participants with the essential skills and knowledge needed for effective field data collection, spatial analysis, and utilizing cutting-edge data collection technologies",
    startDate: "9th April, 2025",
    endDate: "2nd May, 2025",
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
    startDate: "",
    endDate: "",
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
  startDate: "9th April, 2025",
  endDate: "2nd May, 2025",
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
    name: "Geospatial Data Collection & GIS for Professionals",
    picture: dataCollectionImage,
    route: "/track/geospatial-data-collection-and-gis-for-professionals",
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
    "name": "SOKOTO",
    "lgas": [
      "GUDU",
      "BINJI",
      "TANGAZA",
      "GWADABAWA",
      "ILLELA",
      "GADA",
      "SABON BIRNI",
      "ISA",
      "GORONYO",
      "WURNO",
      "RABAH",
      "KWARE",
      "SOKOTO SOUTH",
      "SOKOTO NORTH",
      "WAMAKKO",
      "SILAME",
      "YABO",
      "BODINGA",
      "DANGE SHUNI",
      "TURETA",
      "SHAGARI",
      "TAMBUWAL",
      "KEBBE"
    ]
  },
  {
    "name": "ZAMFARA",
    "lgas": [
      "GUMMI",
      "BUKKUYUM",
      "ANKA",
      "BAKURA",
      "TALATA MAFARA",
      "MARADUN",
      "SHINKAFI",
      "ZURMI MARU",
      "BIRNIN MAGAJI",
      "KAURA NAMODA",
      "TSAFE",
      "GUSAU",
      "BUNGUDU",
      "MARU"
    ]
  },
  {
    "name": "KATSINA",
    "lgas": [
      "BAURE",
      "ZANGO",
      "SANDAMU",
      "DUTSI",
      "DAURA",
      "KUSADA",
      "MAI'ADUA",
      "BINDAWA",
      "MASHI",
      "CHARANCHI",
      "KAITA",
      "KURFI",
      "KATSINA",
      "SAFANA",
      "JIBIA",
      "DUTSIN-MA",
      "BATSARI",
      "KANKIA",
      "BATAGARAWA",
      "MATAZU",
      "RIMI",
      "DAN MUSA",
      "MANI",
      "KANKARA",
      "INGAWA",
      "MUSAWA",
      "MALUNFASHI",
      "KAFUR",
      "BAKORI",
      "SABUWA",
      "DANDUME",
      "FUNTUA",
      "DANJA"
    ]
  },
  {
    "name": "JIGAWA",
    "lgas": [
      "RONI",
      "GWIWA",
      "YANKWASHI",
      "KAZAURE",
      "BABURA",
      "GARKI",
      "SULE TANKAR-KAR",
      "GUMEL",
      "GAGARAWA",
      "MAIGATARI",
      "KAUGAMA",
      "MALAM MADORI",
      "BIRNIWA",
      "GURI",
      "KIRIKASAMMA",
      "HADEJIA",
      "AUYO",
      "KAFIN-HAUSA",
      "MIGA",
      "TAURA",
      "RINGIM",
      "JAHUN",
      "KIYAWA",
      "DUTSE",
      "BIRNIN KUDU",
      "BUJI",
      "GWARAM"
    ]
  },
  {
    "name": "YOBE",
    "lgas": [
      "MACHINA",
      "NGURU",
      "YUSUFARI",
      "YUNUSARI",
      "GEIDAM",
      "BURSARI",
      "KARASUWA",
      "BARDE",
      "JAKUSKO",
      "FUNE",
      "TARMUWA",
      "DAMATURU",
      "GUJBA",
      "GULANI",
      "FIKA",
      "POTISKUM",
      "NANGERE"
    ]
  },
  {
    "name": "BORNO",
    "lgas": [
      "MOBBAR",
      "ABADAN",
      "KUKAWA",
      "GUZAMALA",
      "GUBIO",
      "MAGUMERI",
      "KAGA",
      "KONDUGA",
      "MAIDUGURI",
      "JERE",
      "NGANZAI",
      "MONGUNO",
      "MARTE",
      "MAFA",
      "DIKWA",
      "NGALA",
      "KALA_BALGE",
      "BAMA",
      "GWOZA",
      "DAMBOA",
      "ASKIRA_UBA",
      "CHIBOK",
      "BIU",
      "KWAYA_KUSAR",
      "BAYO",
      "SHANI",
      "HAWUL"
    ]
  },
  {
    "name": "ADAMAWA",
    "lgas": [
      "MADAGALI",
      "MICHIKA",
      "MUBI SOUTH",
      "MAIHA",
      "HONG",
      "GOMBI",
      "SONG",
      "SHELLENG",
      "GUYUK",
      "LAMURDE",
      "NUMAN",
      "DEMSA",
      "YOLA NORTH",
      "YOLA SOUTH",
      "GIREI",
      "FUFORE",
      "MAYO BELWA",
      "JADA",
      "GANYE",
      "TOUNGO"
    ]
  },
  {
    "name": "GOMBE",
    "lgas": [
      "DUKKU",
      "NAFADA",
      "FUNA KAYE",
      "KWAMI",
      "AKKO",
      "GOMBE",
      "YAMALTU_DEBA",
      "BALANGA",
      "KALTUNGO",
      "BILLIRI",
      "SHONGOM"
    ]
  },
  {
    "name": "BAUCHI",
    "lgas": [
      "ZAKI",
      "GAMAWA",
      "ITAS GADAU",
      "JAMA ARE",
      "KATAGUM",
      "SHIRA",
      "GIADE",
      "MISAU",
      "DAMBAM",
      "DARAZO",
      "GANJUWA",
      "WARJI",
      "NINGI",
      "TORO",
      "BAUCHI",
      "KIRFI",
      "ALKALERI",
      "TAFAWA BALEWA",
      "DASS",
      "BOGORO"
    ]
  },
  {
    "name": "KANO",
    "lgas": [
      "KUNCHI",
      "MAKODA",
      "DAMBATTA",
      "GABASAWA",
      "MINJIBIR",
      "DAWAKI TOFA",
      "BICHI",
      "TSANYAWA",
      "SHANONO",
      "BAGWAI",
      "TOFA",
      "UNGOGO",
      "GWALE",
      "DALA",
      "FAGGE",
      "NASARAWA",
      "KANO MUNICIPAL",
      "TARAUNI",
      "KUMBOTSO",
      "GEZAWA",
      "WARAWA",
      "AJINGI",
      "GAYA",
      "WUDIL",
      "DAWAKIN KUDU",
      "MADOBI",
      "RIMIN GADO",
      "KABO",
      "GWARZO",
      "KARAYE",
      "ROGO",
      "KIRU",
      "BEBEJI",
      "GARUN-MALAM",
      "KURA",
      "BUNKURE",
      "RANO",
      "KIBIYA",
      "GARKO",
      "ALBASU",
      "TAKAI",
      "SUMAILA",
      "TUDUN-WADA",
      "DOGUWA"
    ]
  },
  {
    "name": "KADUNA",
    "lgas": [
      "BIRNIN-GWARI",
      "GIWA",
      "SABON-GARI",
      "KUDAN",
      "MAKARFI",
      "IKARA",
      "KUBAU",
      "SOBA",
      "ZARIA",
      "IGABI",
      "KADUNA NORTH",
      "KADUNA SOUTH",
      "CHIKUN",
      "KAJURU",
      "KAURU",
      "LERE",
      "ZANGON KATAF",
      "KACHIA",
      "KAGARKO",
      "JABA",
      "JEMA'A",
      "KAURA",
      "SANGA"
    ]
  },
  {
    "name": "KEBBI",
    "lgas": [
      "AREWA-DANDI",
      "AUGIE",
      "ARGUNGU",
      "GWANDU",
      "BIRNIN KEBBI",
      "ALIERO",
      "JEGA",
      "MAIYAMA",
      "KALGO",
      "BUNZA",
      "SURU",
      "DANDI",
      "BAGUDO",
      "KOKO_BESSE",
      "YAURI",
      "NGASKI",
      "SHANGA",
      "FAKAI",
      "ZURU",
      "DANKO_WASAGU",
      "SAKABA"
    ]
  },
  {
    "name": "NIGER",
    "lgas": [
      "AGWARA",
      "BURGU",
      "MASHEGU",
      "MAGAMA",
      "RIJAU",
      "KONTAGORA",
      "MARIGA",
      "RAFI",
      "SHIRORO",
      "MUNYA",
      "CHANCHAGA",
      "BOSSO",
      "WUSHISHI MINNA",
      "LAVUN",
      "MOKWA",
      "EDATI",
      "GBAKO",
      "BIDA",
      "KATCHA",
      "AGAIE",
      "LAPAI",
      "PAIKORO",
      "GURARA",
      "SULEJA",
      "TAFA"
    ]
  },
  {
    "name": "FCT",
    "lgas": [
      "BWARI",
      "ABUJA MUNICIPAL",
      "GWAGWALADA",
      "ABAJI",
      "KWALI",
      "KUJE"
    ]
  },
  {
    "name": "NASARAWA",
    "lgas": [
      "KARU",
      "KEFFI",
      "KOKONA",
      "AKWANGA",
      "WAMBA",
      "NASSARAWA EGON",
      "LAFIA",
      "AWE",
      "OBI",
      "KEANA",
      "DOMA",
      "NASARAWA",
      "TOTO"
    ]
  },
  {
    "name": "PLATEAU",
    "lgas": [
      "BASSA",
      "JOS NORTH",
      "JOS EAST",
      "JOS SOUTH",
      "RIYOM",
      "BARKIN LADI",
      "MANGU",
      "BOKKOS",
      "QUAN-PAN",
      "PANKSHIN",
      "KANKE",
      "KANAM",
      "WASE",
      "LANTANG NORTH",
      "MIKANG",
      "SHENDAM",
      "LANTANG SOUTH"
    ]
  },
  {
    "name": "TARABA",
    "lgas": [
      "KARIM LAMIDO",
      "LAU",
      "ARDO-KOLA",
      "JALINGO",
      "YORRO",
      "ZING",
      "GASSOL",
      "IBI",
      "WUKARI",
      "BALI",
      "GASHAKA",
      "SARDUNA",
      "KURMI",
      "USSA",
      "TAKUM",
      "DONGA"
    ]
  },
  {
    "name": "BENUE",
    "lgas": [
      "AGATU",
      "APA",
      "GWER WEST",
      "MAKURDI",
      "GUMA",
      "LOGO",
      "UKUM",
      "KATSINA ALA",
      "BURUKU",
      "TARKA",
      "GBOKO",
      "GWER EAST",
      "OTUKPO",
      "OHIMINI",
      "OKPOKWU",
      "OGBADIBO",
      "ADO",
      "OBI",
      "OJU",
      "KONSHISHA",
      "USHONG",
      "KWANDE",
      "VANDEIKYA"
    ]
  },
  {
    "name": "KOGI",
    "lgas": [
      "YAGBA WEST",
      "YAGBA EAST",
      "MAPO MURO",
      "IJUMU",
      "KABBA_BUNU",
      "OKEHI",
      "OGORI_MAGONGO",
      "OKENE",
      "ADAVI",
      "AJAOKUTA",
      "LOKOJA",
      "KOGI",
      "BASSA",
      "DEKINA",
      "OMALA",
      "ANKPA",
      "OLAMABORO",
      "OFU",
      "IGALAMELA-ODOLU",
      "IDAH",
      "IBAJI"
    ]
  },
  {
    "name": "KWARA",
    "lgas": [
      "BARUTEN",
      "KAIAMA",
      "MORO",
      "EDU",
      "PATIGI",
      "IFELODUN",
      "ILORIN SOUTH",
      "ILORIN EAST",
      "ILORIN WEST",
      "ASA",
      "OYUN",
      "OFFA",
      "IREPODUN",
      "ISIN",
      "OKE-ERO",
      "EKITI"
    ]
  },
  {
    "name": "OYO",
    "lgas": [
      "IREPO",
      "OLORUNSOGO",
      "OORELOPE",
      "SAKI EAST",
      "SAKI WEST",
      "ATISBO",
      "ITESIWAJU",
      "ATIBA",
      "ORIIRE",
      "OGBOMOSHO NORTH",
      "SURULERE",
      "OGBOMOSHO SOUTH",
      "OGO-OLUWA",
      "OYO EAST",
      "OYO WEST",
      "ISEYIN",
      "KAJOLA",
      "IWAJOWA",
      "IBARAPA NORTH",
      "IBARAPA EAST",
      "AFIJIO",
      "LAGELU",
      "IBADAN NORTH WEST",
      "IBADAN SOUTH EAST",
      "IBADAN NORTH EAST",
      "EGBEDA",
      "ONA-ARA",
      "OLUYOLE",
      "IBARAPA CENTRAL",
      "IDO",
      "AKINYELE",
      "IBADAN NORTH",
      "IBADAN SOUTH WEST"
    ]
  },
  {
    "name": "OSUN",
    "lgas": [
      "IFEDAYO",
      "ILA",
      "BOLUWADURO",
      "ODO OTIN",
      "IFELODUN",
      "OLORUNDA",
      "IREPODUN",
      "OROLU",
      "EGBEDORE",
      "OSOGBO",
      "BORIPE",
      "OBOKUN",
      "ORIADE",
      "ILESHA EAST",
      "ATAKUMOSA WEST",
      "ILESHA WEST",
      "EDE NORTH",
      "EDE SOUTH",
      "EJIGBO",
      "OLA OLUWA",
      "IWO",
      "AYEDIRE",
      "IREWOLE",
      "ISOKAN",
      "AIYEDADE",
      "IFE NORTH",
      "IFE CENTRAL",
      "IFE EAST",
      "ATAKUNMOSA EAST",
      "IFE SOUTH"
    ]
  },
  {
    "name": "EKITI",
    "lgas": [
      "MOBA",
      "ILEJEMEJE",
      "OYE",
      "IKOLE",
      "EKITI EAST",
      "GBOYIN",
      "ADO EKITI",
      "IREPODUN_IFELODUN",
      "IDO_OSI",
      "IJERO",
      "EKITI WEST",
      "EFON",
      "EKITI SOUTH WEST",
      "IKERE",
      "ISE ORUN",
      "EMURE"
    ]
  },
  {
    "name": "ONDO",
    "lgas": [
      "AKOKO NORTH WEST",
      "AKOKO NORTH EAST",
      "AKOKO SOUTH EAST",
      "AKOKO SOUTH WEST",
      "OSE",
      "OWO",
      "AKURE NORTH",
      "AKURE SOUTH",
      "IFEDORE",
      "ILE OLUJI_OKEIGBO",
      "ONDO WEST",
      "ONDO EAST",
      "IDANRE",
      "ODIGBO",
      "OKITIPUPA",
      "IRELE",
      "ESE ODO",
      "ILAJE"
    ]
  },
  {
    "name": "EDO",
    "lgas": [
      "AKOKO-EDO",
      "ETSAKO EAST",
      "ETSAKO CENTRAL",
      "ETSAKO WEST",
      "OWAN EAST",
      "OWAN WEST",
      "ESAN WEST",
      "ESAN CENTRAL",
      "ESAN NORTH EAST",
      "ESAN SOUTH EAST",
      "IGUEBEN",
      "UHUNMWONDE",
      "OVIA NORTH EAST",
      "OVIA SOUTH WEST",
      "EGOR",
      "OREDO",
      "IKPOBA-OKHA",
      "ORHIONMWON"
    ]
  },
  {
    "name": "ANAMBRA",
    "lgas": [
      "ANAMBRA WEST",
      "AYAMELUM",
      "AWKA NORTH",
      "ANAMBRA EAST",
      "OYI",
      "DUNUKOFIA",
      "NJIKOKA",
      "AWKA SOUTH",
      "ORUMBA NORTH",
      "ANAOCHA",
      "IDEMILI NORTH",
      "ONITSHA NORTH",
      "ONITSHA SOUTH",
      "OGBARU",
      "IDEMILI SOUTH",
      "NNEWI NORTH",
      "EKWUSIGO",
      "IHIALA",
      "NNEWI SOUTH",
      "AGUATA",
      "ORUMBA SOUTH"
    ]
  },
  {
    "name": "ENUGU",
    "lgas": [
      "IGBO EZE NORTH",
      "IGBO EZE SOUTH",
      "UDENU",
      "ISI-UZO",
      "IGBO ETITI",
      "NSUKKA",
      "UZO UWANI",
      "EZE AGU",
      "UDI",
      "ENUGU EAST",
      "NKANU EAST",
      "ENUGU NORTH",
      "ENUGU SOUTH",
      "NKANU WEST",
      "ANINRI",
      "AWGU",
      "OJI RIVER"
    ]
  },
  {
    "name": "EBONYI",
    "lgas": [
      "ISHIELU",
      "OHAUKWU",
      "EBONYI",
      "IZZI",
      "ABAKALIKI",
      "EZZA NORTH",
      "EZZA SOUTH",
      "IKWO",
      "ONICHA",
      "OHAOZARA",
      "AFIKPO NORTH",
      "AFIKPO SOUTH",
      "IVO"
    ]
  },
  {
    "name": "CROSS-RIVER",
    "lgas": [
      "YALLA",
      "BEKWARRA",
      "OGOJA",
      "OBUDU",
      "OBANLIKU",
      "BOKI",
      "ETUNG",
      "IKOM",
      "OBUBRA",
      "YAKURR",
      "ABI",
      "BIASE",
      "AKAMKPA",
      "ODUKPANI",
      "CALABAR SOUTH",
      "CALABAR MUNICIPAL",
      "AKPABUYO",
      "BAKASSI"
    ]
  },
  {
    "name": "AKWA-IBOM",
    "lgas": [
      "INI",
      "OBOT-AKARA",
      "IKOT EKPENE",
      "IKONO",
      "IBIONO IBOM",
      "ITU",
      "URUAN",
      "UYO",
      "ABAK",
      "ESSIEN-UDIM",
      "IKA",
      "ETIM-EKPO",
      "UKANAFUN",
      "ORUK-ANAM",
      "MPKAT-ENIN",
      "ETINAN",
      "NSIT-IBOM",
      "IBESIKPO ASUTAN",
      "NSIT-ATAI",
      "OKOBO",
      "ORON",
      "UDUNG-UKO",
      "MBO",
      "URUE-OFFONG-ORUKO",
      "ESIT EKET",
      "NSIT UBIUM",
      "EKET",
      "ONNA",
      "IBENO",
      "EASTERN OBOLO",
      "IKOT ABASI"
    ]
  },
  {
    "name": "ABIA",
    "lgas": [
      "UMU NNEOCHI",
      "ISIUKWUATO",
      "BENDE",
      "OHAFIA",
      "AROCHUKWU",
      "UMUAHIA NORTH",
      "UMUAHIA SOUTH",
      "IKWUANO",
      "ISIALA NGWA NORTH",
      "ISIALA NGWA SOUTH",
      "OBINGWA",
      "ABA NORTH",
      "OSISIOMA",
      "ABA SOUTH",
      "UGWUNAGBO",
      "UKWA EAST",
      "UKWA WEST"
    ]
  },
  {
    "name": "IMO",
    "lgas": [
      "IDEATO NORTH",
      "OKIGWE",
      "ONUIMO",
      "IDEATO SOUTH",
      "ORLU",
      "ORSU",
      "ORU EAST",
      "ORU WEST",
      "OGUTA",
      "MBAITOLI",
      "NJABA",
      "ISU",
      "NKWERRE",
      "NWANGELE",
      "ISIALA MBANO",
      "EHIME MBANO",
      "IHITTE UBOMA",
      "OBOWO",
      "EZINIHITTE-MBAISE",
      "AHIAZU-MBAISE",
      "ABOH-MBAISE",
      "IKEDURU",
      "OWERRI NORTH",
      "OWERRI MUNICIPAL",
      "OWERRI WEST",
      "OHAJI_EGBEMA",
      "NGOR OKPALA"
    ]
  },
  {
    "name": "RIVERS",
    "lgas": [
      "OGBA_EGBEMA_NDONI",
      "AHOADA EAST",
      "AHOADA WEST",
      "ABUA_ODUA",
      "AKUKU TORU",
      "DEGEMA",
      "ASARI-TORU",
      "EMUOHA",
      "IKWERRE",
      "ETCHE",
      "OMUMA",
      "OBIO_AKPOR",
      "PORTHARCOURT",
      "OKRIKA",
      "ELEME",
      "OYIGBO",
      "KHANA",
      "GOKHANA",
      "TAI",
      "OGU_BOLO",
      "BONNY",
      "ANDONI",
      "OPOBO_NKORO"
    ]
  },
  {
    "name": "BAYELSA",
    "lgas": [
      "EKEREMOR",
      "SAGBAMA",
      "KOLOKUMA_OPOKUMA",
      "YENAGOA",
      "OGBIA",
      "SOUTHERN IJAW",
      "BRASS",
      "NEMBE"
    ]
  },
  {
    "name": "DELTA",
    "lgas": [
      "IKA SOUTH",
      "IKA NORTH EAST",
      "ANIOCHA NORTH",
      "OSHIMILI NORTH",
      "ANIOCHA SOUTH",
      "OSHIMILI SOUTH",
      "NDOKWA EAST",
      "NDOKWA WEST",
      "UKWUANI",
      "UGHELLI NORTH",
      "ETHIOPE EAST",
      "ISOKO NORTH",
      "ISOKO SOUTH",
      "PATANI",
      "UGHELLI SOUTH",
      "UVWIE",
      "OKPE",
      "ETHIOPE WEST",
      "SAPELE",
      "WARRI NORTH",
      "WARRI SOUTH WEST",
      "WARRI SOUTH",
      "UDU",
      "BURUTU",
      "BOMADI"
    ]
  },
  {
    "name": "LAGOS",
    "lgas": [
      "OJO",
      "AMUWO ODOFIN",
      "ALIMOSHO",
      "AGEGE",
      "IFAKO-IJAIYE",
      "IKEJA",
      "OSHODI ISOLO",
      "MUSHIN",
      "SURULERE",
      "AJEROMI-IFELODUN",
      "APAPA",
      "LAGOS ISLAND",
      "LAGOS MAINLAND",
      "SHOMOLU",
      "KOSOFE",
      "IKORODU",
      "ETI-OSA",
      "IBEJU-LEKKI",
      "EPE"
    ]
  },
  {
    "name": "OGUN",
    "lgas": [
      "IMEKO_AFON",
      "EGBADO NORTH",
      "ABEOKUTA NORTH",
      "ABEOKUTA SOUTH",
      "ODEDA",
      "OBAFEMI OWODE",
      "EWEKORO",
      "EGBADO SOUTH",
      "IPOKIA",
      "ADO-ODO_OTA",
      "IFO",
      "SAGAMU",
      "IKENNE",
      "REMO NORTH",
      "IJEBU NORTH",
      "ODOGBOLU",
      "IJEBU-ODE",
      "IJEBU NORTH EAST",
      "IJEBU EAST",
      "OGUN WATERSIDE"
    ]
  }
];

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
