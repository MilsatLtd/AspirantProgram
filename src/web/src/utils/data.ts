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
  quickLinks : [
    {
        id:1,
        name: 'Application Here',
        link: "/apply"
    },
    {
        id:1, 
        name: 'Terms and Conditions',
        link: 'apply/T&C'
    }
  ],
  tracks : [
    {
        id:1,
        name: 'Community Developer',
        link: '/track/1'
    },
    {
        id:2,
        name: 'Geospatial Designer',
        link: '/track/2'
    },
    {
        id:3,
        name: 'Geospatial Front-end',
        link: '/track/3'
    },
    {
        id:4,
        name: 'Geospatial Analyst',
        link: '/track/4'
    },
    {
        id:5,
        name: 'Geospatial Back-end',
        link: '/track/5'
    },
    {
        id:6,
        name: 'Geospatial Mobile Developer',
        link: '/track/6'
    }
  ]
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
    criteria: "Lorem ipsum dolor sit amet consectetur.",
  },
  {
    id: 2,
    criteria: "Lorem ipsum dolor sit amet consectetur.",
  },
  {
    id: 3,
    criteria: "Lorem ipsum dolor sit amet consectetur.",
  },
];

export const AvailableTracks = [
  {
    id: "1",
    trackName: "Community Developer",
    description:
      "Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum.",
    learningTimeLine: "5 weeks",
    TrackInfo: [
      {
        name: "Track-curriculum",
        list: [
          {
            id: 1,
            criteria:
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
          },
          {
            id: 2,
            criteria:
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
          },
          {
            id: 3,
            criteria:
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
          },
        ],
      },
      {
        name: "What to learn",
        list: [
          {
            id: 1,
            criteria:
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
          },
          {
            id: 2,
            criteria:
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
          },
          {
            id: 3,
            criteria:
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
          },
        ],
      },
      {
        name: "Track Requirement",
        list: [
          {
            id: 1,
            criteria:
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
          },
          {
            id: 2,
            criteria:
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
          },
          {
            id: 3,
            criteria:
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
          },
        ],
      },
    ],
  },
  {
    id: "3",
    trackName: "Geospatial Front-end",
    description:
      "Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum.",
    learningTimeLine: "5 weeks",
    TrackInfo: [
      {
        name: "Track-curriculum",
        list: [
          {
            id: 1,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 2,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 3,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 4,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
        ],
      },
      {
        name: "Track Requirement",
        list: [
          {
            id: 1,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 2,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 3,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 4,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 5,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
        ],
      },
    ],
  },
  {
    id: "2",
    trackName: "Geospatial Designer",
    description:
      "Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum.",
    learningTimeLine: "5 weeks",
    TrackInfo: [
      {
        name: "Track-curriculum",
        list: [
          {
            id: 1,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 2,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 3,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 4,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
        ],
      },
      {
        name: "Track Requirement",
        list: [
          {
            id: 1,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 2,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 3,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 4,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 5,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
        ],
      },
    ],
  },
  {
    id: "4",
    trackName: "Geospatial Back-end",
    description:
      "Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum.",
    learningTimeLine: "5 weeks",
    TrackInfo: [
      {
        name: "Track-curriculum",
        list: [
          {
            id: 1,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 2,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 3,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 4,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
        ],
      },
      {
        name: "Track Requirement",
        list: [
          {
            id: 1,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 2,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 3,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 4,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 5,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
        ],
      },
    ],
  },
  {
    id: "5",
    trackName: "Geospatial Analyst",
    description:
      "Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum.",
    learningTimeLine: "5 weeks",
    TrackInfo: [
      {
        name: "Track-curriculum",
        list: [
          {
            id: 1,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 2,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 3,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 4,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
        ],
      },
      {
        name: "Track Requirement",
        list: [
          {
            id: 1,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 2,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 3,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 4,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 5,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
        ],
      },
    ],
  },
  {
    id: "6",
    trackName: "Geospatial Mobile Developer",
    description:
      "Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum.",
    learningTimeLine: "5 weeks",
    TrackInfo: [
      {
        name: "Track-curriculum",
        list: [
          {
            id: 1,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 2,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 3,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 4,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
        ],
      },
      {
        name: "Track Requirement",
        list: [
          {
            id: 1,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 2,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 3,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 4,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
          {
            id: 5,
            criteria: "Lorem ipsum dolor sit amet consectetur.",
          },
        ],
      },
    ],
  },
];

export const applictionTimeline = {
  statDate: "00 November, 2023",
  endDate: "00 December, 2023",
};

export const termsAndConditions = {
  firstTerms:
    "I hereby declare that all information  provided are accurate and complete",
  secondTerms:
    "Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum lobortis nulla. Quis adipiscing pretium feugiat vulputate non",
};

export const TAndCDetails = [
  {
    id: 1,
    title: "Lorem ipsum dolor sit amet",
    description:
      "Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum lobortis nulla. Quis adipiscing pretium feugiat vulputate non egestas elementum sagittis bibendum. Sagittis leo magna rhoncus pellentesque vitae quis volutpat vitae suscipit. Magnis platea diam. Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum lobortis nulla. Quis adipiscing pretium feugiat vulputate non egestas elementum sagittis bibendum. Sagittis leo magna rhoncus pellentesque vitae quis volutpat vitae suscipit. Magnis platea diam.",
  },
  {
    id: 2,
    title: "Lorem ipsum dolor sit amet",
    description:
      "Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum lobortis nulla. Quis adipiscing pretium feugiat vulputate non egestas elementum sagittis bibendum. Sagittis leo magna rhoncus pellentesque vitae quis volutpat vitae suscipit. Magnis platea diam. Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum lobortis nulla. Quis adipiscing pretium feugiat vulputate non egestas elementum sagittis bibendum. Sagittis leo magna rhoncus pellentesque vitae quis volutpat vitae suscipit. Magnis platea diam.",
  },
  {
    id: 3,
    title: "Lorem ipsum dolor sit amet",
    description:
      "Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum lobortis nulla. Quis adipiscing pretium feugiat vulputate non egestas elementum sagittis bibendum. Sagittis leo magna rhoncus pellentesque vitae quis volutpat vitae suscipit. Magnis platea diam. Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum lobortis nulla. Quis adipiscing pretium feugiat vulputate non egestas elementum sagittis bibendum. Sagittis leo magna rhoncus pellentesque vitae quis volutpat vitae suscipit. Magnis platea diam.",
  },
];

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
    name: "Community Developer",
    picture: community,
    route: "/track/1",
  },
  {
    id: 2,
    name: "Geospatial Designer",
    picture: designer,
    route: "/track/2",
  },
  {
    id: 3,
    name: "Geospatial Front-end",
    picture: frontend,
    route: "/track/3",
  },
  {
    id: 4,
    name: "Geospatial Analyst",
    picture: frontend,
    route: "/track/4",
  },
  {
    id: 5,
    name: "Geospatial Back-end",
    picture: frontend,
    route: "/track/5",
  },
  {
    id: 6,
    name: "Geospatial Moblie Developer",
    picture: frontend,
    route: "/track/6",
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
      "Gain valuable insights into the GIS industry, its applications, and future developments from experts in the field.",
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
        question: "What is M.A.P",
        answer:
          "Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum lobortis nulla. Quis adipiscing pretium feugiat vulputate non egestas elementum sagittis bibendum. Sagittis leo magna rhoncus pellentesque vitae quis volutpat vitae suscipit. Magnis platea diam.",
      },
      {
        id: 2,
        question: "Lorem ipsum dolor sit amet consectetur. ",
        answer:
          "Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum lobortis nulla. Quis adipiscing pretium feugiat vulputate non egestas elementum sagittis bibendum. Sagittis leo magna rhoncus pellentesque vitae quis volutpat vitae suscipit. Magnis platea diam.",
      },
      {
        id: 3,
        question: "Lorem ipsum dolor sit amet consectetur. ",
        answer:
          "Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum lobortis nulla. Quis adipiscing pretium feugiat vulputate non egestas elementum sagittis bibendum. Sagittis leo magna rhoncus pellentesque vitae quis volutpat vitae suscipit. Magnis platea diam.",
      },
    ],
  },
  {
    id: 2,
    faqTitle: "Programme Scope",
    faqList: [
      {
        id: 1,
        question: "What is M.A.P",
        answer:
          "Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum lobortis nulla. Quis adipiscing pretium feugiat vulputate non egestas elementum sagittis bibendum. Sagittis leo magna rhoncus pellentesque vitae quis volutpat vitae suscipit. Magnis platea diam.",
      },
      {
        id: 2,
        question: "Lorem ipsum dolor sit amet consectetur. ",
        answer:
          "Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum lobortis nulla. Quis adipiscing pretium feugiat vulputate non egestas elementum sagittis bibendum. Sagittis leo magna rhoncus pellentesque vitae quis volutpat vitae suscipit. Magnis platea diam.",
      },
      {
        id: 3,
        question: "Lorem ipsum dolor sit amet consectetur. ",
        answer:
          "Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum lobortis nulla. Quis adipiscing pretium feugiat vulputate non egestas elementum sagittis bibendum. Sagittis leo magna rhoncus pellentesque vitae quis volutpat vitae suscipit. Magnis platea diam.",
      },
    ],
  },
];

export const MobileFeatures = [
  {
    id: 1,
    description:
      "Lorem ipsum dolor sit amet consectetur. Faucibus volutpat imperdiet dictum.",
  },
  {
    id: 2,
    description: "Lorem ipsum dolor sit amet consectetur. ",
  },
  {
    id: 3,
    description: "Lorem ipsum dolor sit amet consectetur. ",
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
