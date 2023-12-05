import instagram from "../Assets/instagram.svg";
import linkedin from "../Assets/linkedin.svg";
import twitter from "../Assets/twitter.svg";
import community from "../Assets/community-picture.jpeg";
import frontend from "../Assets/frontend-picture.jpeg";
import designer from "../Assets/designer-picture.jpeg";
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
      id: 2,
      name: "Fundamental of GIS",
      link: "/track/fundamental-of-gis",
    },
    {
      id: 1,
      name: "Field Mapping and Data Collection",
      link: "/track/field-mapping-and-data-collection",
    },

    // {
    //     id:3,
    //     name: 'Geospatial Front-end',
    //     link: '/track/3'
    // },
    // {
    //     id:4,
    //     name: 'Geospatial Analyst',
    //     link: '/track/4'
    // },
    // {
    //     id:5,
    //     name: 'Geospatial Back-end',
    //     link: '/track/5'
    // },
    // {
    //     id:6,
    //     name: 'Geospatial Mobile Developer',
    //     link: '/track/6'
    // }
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
    id: "fundamental-of-gis",
    trackName: "Fundamental of GIS",
    description:
      "Explore the foundational principles and essential skills of Geographic Information Systems (GIS) in this beginner-friendly track, gaining a solid understanding of the system",
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
        ],
      },
      {
        name: "Track Requirement",
        list: [
          {
            id: 1,
            criteria:
              "Completed the Milsat Field Mapping and Data Collection Certification Courses",
          },
          {
            id: 2,
            criteria: "Completed and passed the Basic Gis Courses",
          },
          {
            id: 3,
            criteria:
              "Proficient Understanding of GIS and the Practical Procedure of Data Collection",
          },
        ],
      },
    ],
  },
  {
    id: "field-mapping-and-data-collection",
    trackName: "Field Mapping and Data Collection",
    description:
      "Dive into fundamental topics such as GIS basics, data collection techniques, technology integration, mapping best practices, data analysis, and practical applications",
    learningTimeLine: "5 weeks",
    TrackInfo: [
      {
        name: "Track-curriculum",
        list: [
          {
            id: 1,
            criteria: "Introduction to Field Mapping and Data Collection",
          },
          {
            id: 2,
            criteria: "Geographic Information Systems (GIS) Basics",
          },
          {
            id: 3,
            criteria: "Data Collection Techniques",
          },
          {
            id: 4,
            criteria: "Technology and Field Devices",
          },
          {
            id: 5,
            criteria: "Field Mapping Best Practices",
          },
          {
            id: 6,
            criteria: "Data Analysis and Visualization",
          },
          {
            id: 7,
            criteria: "Practical Applications",
          },
          {
            id: 8,
            criteria: "Final Project",
          },
        ],
      },
      {
        name: "Track Requirement",
        list: [
          {
            id: 1,
            criteria: " Basic computer skills.",
          },
          {
            id: 2,
            criteria: "Understanding of geographic concepts.",
          },
          {
            id: 3,
            criteria: "Access to a computer with internet connectivity.",
          },
        ],
      },
    ],
  }
];

export const applictionTimeline = {
  statDate: "12 November, 2023",
  endDate: "31 December, 2023",
};

export const termsAndConditions = {
  firstTerms:
    "I hereby declare that all information  provided are accurate and complete",
  secondTerms:
    "Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum lobortis nulla. Quis adipiscing pretium feugiat vulputate non",
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
    id: 1,
    name: "Fundamental of GIS",
    picture: community,
    route: "/track/fundamental-of-gis", 
  },
  {
    id: 2,
    name: "Field Mapping and Data Collection",
    picture: designer,
    route: "/track/field-mapping-and-data-collection",
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
        question: "Is this course really 100% online, do I need to attend any classes in person?",
        answer:
          "This course is completely online, so there’s no need to show up to a classroom in person. You have the flexibility to reach your lectures, readings, and assignments at your convenience, whether through the web or on your mobile device, from any location.",
      },
    ],
  }
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


export const Brochure =  {
  FundamentalOfGIS: "/Fundamental_of_GIS.pdf",
  FieldMappingAndDataCollection: "/Milsat_GIS_training_curriculum_Basic.pdf",
}