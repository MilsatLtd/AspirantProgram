/** @type {import('tailwindcss').Config} */
import bg from ".."

module.exports = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx}',
    './src/components/**/*.{js,ts,jsx,tsx}',
    './src/app/**/*.{js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {
      boxShadow: {
        '2xl': '0px 0px 32px 4px rgba(14, 73, 69, 0.1)',
        '1xl': '0px 8px 32px 2px rgba(143, 48, 143, 0.15)'
      },
      colors: {
        /***** Brand Color *****/


        /* Primary Color */
        "P50": '#f2ebf3',
        "P75": '#cbadcd',
        "P100": '#b58bb8',
        "P200": '#96599a',
        "P300": '#803785',
        "P400": '#5a275d',
        "P500": '#4e2251',


        /* Secondary Color */

        "S50": '#e6f7f6',
        "S75": '#96ded9',
        "S100": '#6bd1c9',
        "S200": '#2bbdb2',
        "S300": '#00afa2',
        "S400": '#007a71',
        "S500": '#006b63',

        /* Neutral Color */
        "N00": '#ffffff',
        "N50": '#eeedee',
        "N75": '#B7B6B8',
        "N100": '#9a989a',
        "N200": '#6e6b6f',
        "N300": '#504d51',
        "N400": '#383639',
        "N500": '#312f31',

        /* Error Color */
        "R50": '#fee6f0',
        "R75": '#f99ac0',
        "R100": '#f770a6',
        "R200": '#f33380',
        "R300": '#f10966',
        "R400": '#a90647',
        "R500": '#93053e',


         /* Success Color */
         "G50": '#e7f6ef',
         "G75": '#9dd9bf',
         "G100": '#75c9a5',
         "G200": '#2BBDB2',
         "G300": '#11a263',
         "G400": '#007A71',
         "G500": '#0a633c',


      },
      fontSize: {

        /****** Web Typography (fontsize) *******/

        'xs': '.444rem',
        '2xs': '.556rem',
        'sm': '.778rem',
        'base': '1.000rem',
        'lg': '1.333rem',
        'xl': '1.778rem',
        '2xl': '2.389rem',
        '3xl': '3.167rem',
        '4xl': '4.222rem',

        /****** Mobile Typography (fontsize) *******/

        'm-xs': '.625rem',
        'm-sm': '.812rem',
        'm-base': '1.000rem',
        'm-lg': '1.250rem',
        'm-xl': '1.562rem',
        'm-2xl': '1.938rem',
        'm-3xl': '2.438rem',
        'm-4xl': '3.062rem'

      },
      fontWeight: {
        regular: '400',
        medium: '500',
        semibold: '600',
        bold: '700',
        extrabold: '800',
      },
      spacing: {

        /****** Spacing Typography (fontsize) *******/

        '2': '2px',
        '3': '3px',
        '4': '2px',
        '6': '6px',
        '8': '8px',
        '10': '10px',
        '12': '12px',
        '14': '14px',
        '16': '16px',
        '18': '18px',
        '20': '20px',
        '22': '22px',
        '24': '24px',
        '26': '26px',
        '28': '28px',
        '30': '30px',
        '32': '32px',
        '34': '34px',
        '36': '36px',
        '38': '38px',
        '40': '40px',
        '42': '42px',
        '44': '44px',
        '48': '48px',
        '50': '50px',
        '52': '52px',
        '54': '54px',
        '56': '56px',
        '58': '58px',
        '96': '96px'
      },
      boxShadow: {
        /****** shadow for containers *******/
        'lg':  '0px 6.94684px 27.7873px -1.73671px rgba(143, 48, 143, 0.15)',
         'xl': '0px 2px 8px rgba(56, 54, 57, 0.05)',
         'lg': '0px 0px 16px rgba(49, 47, 49, 0.15)',
         'card': '0px 8px 32px -2px rgba(143, 48, 143, 0.15)'
     }
    },
  },  
  plugins: [
    require('tailwind-scrollbar-hide')
  ],
}
