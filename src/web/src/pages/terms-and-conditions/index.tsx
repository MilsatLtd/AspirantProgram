import Footer from "@/components/organism/Footer";
import Header from "@/components/organism/Header";
import blurEffectTopRight from "../../Assets/blur-effect-top-right.svg";
import Link from "next/link";
import React from "react";
import Head from "next/head";

const TermsConditionsPage = () => {
  return (
    <>
      <Head>
        <title>Terms and Condition</title>
        <meta
          name="description"
          content="Our Terms and Condition for Milsat Aspirant Programme"
        />
        <meta
          name="keywords"
          content="MAP, Aspirant Programmer, GIS Training, Milsat, Education, GIS Skills, GIS Mentorship, Esri,Fundamental of GIS, Field Mapping, Data collection, Africa GIS, Data, learning GIS"
        />

        {/* Add a link to your favicon (replace 'favicon.ico' with your actual favicon) */}
        <link rel="icon" href="/favicon.ico" />

        {/* Add an Open Graph image (replace 'og-image.jpg' with your actual image)
      <meta property="og:image" content="/og-image.jpg" /> */}

        {/* Add a canonical URL if needed */}
        <link
          rel="canonical"
          href="https://aspirant.milsat.africa/terms-and-condition"
        />

        {/* Add your CSS styles or external stylesheets */}
        <link rel="stylesheet" href="/styles.css" />

        {/* Add your logo image (replace 'logo.png' with your actual logo) */}
        <link rel="apple-touch-icon" sizes="180x180" href="/logo.png" />
        <link rel="icon" type="image/png" sizes="32x32" href="/logo.png" />
        <link rel="icon" type="image/png" sizes="16x16" href="/logo.png" />

        {/* Specify the viewport for responsive design */}
        <meta name="viewport" content="width=device-width, initial-scale=1" />
      </Head>
      <div>
        <div
          className="w-full bg-no-repeat bg-cover"
          style={{
            backgroundImage: `url(${blurEffectTopRight.src})`,
          }}
        >
          <Header showNavLinks={false} showApplyButton={true} />
          <main className="lg:w-[50%] w-full mx-auto space-y-24 lg:my-[6%] my-[56px] lg:px-0 md:px-0 px-16">
            <h2 className="font-bold lg:text-xl text-m-xl lg:leading-[40px] leading-[30px] text-N400 text-center lg:mb-[88px] mb-[56px]">
              Terms of Service
            </h2>
            <section >
              <h2 className="lg:leading-[32px] leading-[28px] text-m-lg lg:text-lg text-N400 font-bold uppercase">
                Privacy Policy
              </h2>
              <div className="space-y-16">
                <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  This Privacy Policy is an integral part of the Terms of
                  Service of{" "}
                  <a
                    href="https://aspirant.milsat.africa/"
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-P300 "
                  >
                    https://aspirant.milsat.africa/
                  </a>{" "}
                  and governs how Milsat Technologies Limited ("Milsat," "we,"
                  "our," "us") which include its affiliates and subsidiaries,
                  collects, uses, stores, protects, and discloses the
                  information obtained through the use of Milsat services. Your
                  privacy is of utmost importance to us, and we are committed to
                  ensuring the confidentiality, integrity, and security of your
                  personal information when you visit, access, browse through
                  and/or use our Website{" "}
                  <a
                    href="https://aspirant.milsat.africa/"
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-P300 "
                  >
                    Milsat Aspirant
                  </a>{" "}
                  or Services; including but not limited to mobile applications
                  and digital platforms.
                </p>
                <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  <b>“Personal data”</b> means information that alone or when in
                  combination with other information may be used to readily
                  identify, contact, or locate you, such as name, address, email
                  address, passwords, payment information, phone number, and
                  banking information. We do not consider personal data to
                  include information that has been de-identified so that it
                  does not allow a third party to easily identify a specific
                  individual.
                </p>
                <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  By using any of our services provided, you acknowledge that
                  you have read, understood and accepted the terms, conditions,
                  notices and disclaimers contained in this document and in the
                  Privacy Policy.
                </p>
                <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  <b>“User”</b> means an individual who uses our services and
                  has agreed to the terms of use.
                </p>
              </div>
            </section>
            <section>
              <div>
                <h3 className="lg:leading-[32px] leading-[28px] text-m-lg lg:text-lg text-N400 font-bold uppercase">
                  Introduction
                </h3>
                <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  In today’s digital age, data protection is essential for
                  businesses operating globally. With increasing privacy and
                  data protection regulations across various jurisdictions,
                  compliance is not only a legal requirement but also a
                  strategic advantage. A strong data protection strategy
                  enhances consumer confidence and upholds the fundamental right
                  to privacy. Our goal is to provide our clients with
                  comprehensive, tailored strategies to navigate privacy and
                  data protection challenges effectively.
                </p>
              </div>
            </section>
            <section>
              <div>
                <h3 className="lg:leading-[32px] leading-[28px] text-m-lg lg:text-lg text-N400 font-bold uppercase">
                  Consent
                </h3>
                <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  By accessing or using our Service, you signify that you have
                  read, understood, and agree to our collection, storage, use,
                  and disclosure of your personal information as described in
                  this Privacy Policy and our Terms of Service.{" "}
                </p>
              </div>
            </section>
            <section>
              <div>
                <h3 className="lg:leading-[32px] leading-[28px] text-m-lg lg:text-lg text-N400 font-bold uppercase">
                  Information We Collect and Use
                </h3>
                <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  For purposes of this Policy, “Personal Data” is any
                  information that identifies, relates to, or describes,
                  directly or indirectly, an individual or household.
                </p>
                <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  In the course of operating <b>our services</b>, we collect and
                  use your personal data to deliver our services, comply with
                  legal requirements, address your inquiries, offer customer
                  support, enhance our offerings, fulfill our contractual
                  obligation and maintain our relationship with you.
                </p>
                <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  This Privacy Policy applies to our services but we do not
                  exercise control over third party sites displayed or linked
                  from within our various services. These other sites may place
                  their cookies, or other files on your device, collect data or
                  solicit personal data from you. We do not control these
                  third-party websites and we are not responsible for their
                  privacy statements. Please consult such third parties’ privacy
                  policies.
                </p>
              </div>
              <div>
                <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  The personal information may include:
                </p>
                <ul className="list-disc pl-40 my-[1rem]">
                  <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    Your full name;
                  </li>
                  <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    Your email address;
                  </li>
                  <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    Your address;
                  </li>
                  <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    Gender
                  </li>
                  <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    Your telephone number;
                  </li>
                  <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    The domain name of the Internet service provider (ISP);
                  </li>
                  <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    Date and time of your visits to our Website;
                  </li>
                  <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    Login email addresses and passwords;
                  </li>
                  <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    IP address;
                  </li>
                </ul>
              </div>
            </section>
            <section>
              <h3 className="lg:leading-[32px] leading-[28px] text-m-lg lg:text-lg text-N400 font-bold uppercase">
                Purpose of Processing Your Personal Data and Lawful Basis
              </h3>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                At Milsat, we process your personal data only when we have a
                valid legal reason to do so, as required by applicable data
                protection laws. Our privacy team assesses and documents the
                appropriate lawful basis for each processing activity.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                Depending on the context, we may process your data on one or
                more of the following grounds: to perform a contract with you,
                to comply with a legal or regulatory obligation, based on our
                legitimate business interests (provided they do not override
                your rights), or where necessary, with your explicit consent.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                Where we rely on your consent, we will make sure to request it
                in a clear and transparent manner. You are free to refuse or
                withdraw your consent at any time by emailing us at{" "}
                <a
                  href="mailto:support@milsat.tech"
                  className="text-P300 "
                >
                  support@milsat.tech
                </a>{" "}
                or by opting out through the channels provided. Please note that
                withdrawing consent does not affect the lawfulness of any
                processing carried out before your withdrawal.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                Below is a summary table of why we collect and use your personal
                data, along with the corresponding lawful basis for each
                purpose:
              </p>
            </section>
            <section>
              <div>
                <h2 className="lg:leading-[32px] leading-[28px]  text-m-base lg:text-base text-N400 font-bold">
                  Information Provided by Other Users
                </h2>
                <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  Other users may provide us with your personal identifiers
                  (such as your email address) or other relevant information to
                  invite you to use our mobile services or share content with
                  you. We will only use this information for the purposes for
                  which it was provided.
                </p>
              </div>
              <div>
                <h2 className="lg:leading-[32px] leading-[28px]  text-m-base lg:text-base text-N400 font-bold">
                  Information We Collect
                </h2>
                <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  We may collect information about you, your device, and your
                  use of our mobile services in the following ways:
                </p>
              </div>
              <div>
                <h2 className="lg:leading-[32px] leading-[28px]  text-m-base lg:text-base text-N400 font-bold">
                  Information You Provide:
                </h2>
                <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  You may choose to provide certain information when using our
                  services, such as when you create an account, submit
                  inquiries, or interact with features within the app. If you
                  choose not to provide specific information, some
                  functionalities may be limited.
                </p>
              </div>
              <div>
                <h2 className="lg:leading-[32px] leading-[28px]  text-m-base lg:text-base text-N400 font-bold">
                  Information Collected Automatically:
                </h2>
                <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  When you use our mobile services, we automatically collect
                  certain data, including:
                </p>
              </div>
              <ul className="list-disc pl-40 my-[1rem]">
                <li>
                  <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    <b className="lg:leading-[32px] leading-[28px]  text-m-base lg:text-base text-N400 font-bold">
                      Device Information:
                    </b>{" "}
                    This includes your device model, operating system version,
                    unique device identifiers, and other device-related data.
                  </p>
                </li>
                <li>
                  <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    <b className="lg:leading-[32px] leading-[28px]  text-m-base lg:text-base text-N400 font-bold">
                      Usage Information:
                    </b>{" "}
                    We track interactions with the services, such as feature
                    usage, session duration, and engagement with specific
                    content.
                  </p>
                </li>
                <li>
                  <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    <b className="lg:leading-[32px] leading-[28px]  text-m-base lg:text-base text-N400 font-bold">
                      Browsing Information:
                    </b>{" "}
                    Your IP address is recorded to help us monitor app usage
                    patterns and improve security.
                  </p>
                </li>
                <li>
                  <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    <b className="lg:leading-[32px] leading-[28px]  text-m-base lg:text-base text-N400 font-bold">
                      IP Address:
                    </b>{" "}
                    Your IP address is recorded to help us monitor app usage
                    patterns and improve security.
                  </p>
                </li>
                <li>
                  <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    <b className="lg:leading-[32px] leading-[28px]  text-m-base lg:text-base text-N400 font-bold">
                      Location Information:
                    </b>{" "}
                    With your consent, we may collect real-time geo-location
                    data through GPS, Wi-Fi networks, and other sensors. This
                    helps enhance app features, provide location-based services,
                    and improve your user experience.
                  </p>
                </li>
                <li>
                  <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    <b className="lg:leading-[32px] leading-[28px]  text-m-base lg:text-base text-N400 font-bold">
                      Behavioral Analytics:
                    </b>{" "}
                    We analyze app usage data to understand user preferences and
                    improve our services accordingly.
                  </p>
                </li>
              </ul>
            </section>
            <section>
              <h2 className="lg:leading-[32px] leading-[28px] text-m-base lg:text-base text-N400 font-bold">
                Use of Cookies and Tracking Technologies
              </h2>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                We utilize various technologies to collect and store
                information, including cookies, device identifiers, and
                analytics tools. These help us:
              </p>
              <ul className="list-disc pl-40 my-[1rem]">
                <li>
                  <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    <b className="lg:leading-[32px] leading-[28px]  text-m-base lg:text-base text-N400 font-bold">
                      Device Information:
                    </b>{" "}
                    This includes your device model, operating system version,
                    unique device identifiers, and other device-related data.
                  </p>
                </li>
                <li>
                  <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    <b className="lg:leading-[32px] leading-[28px] text-m-base lg:text-base text-N400 font-bold">
                      Usage Information:
                    </b>{" "}
                    We track interactions with the services, such as feature
                    usage, session duration, and engagement with specific
                    content.
                  </p>
                </li>
                <li>
                  <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    <b className="lg:leading-[32px] leading-[28px]  text-m-base lg:text-base text-N400 font-bold">
                      Browsing Information:
                    </b>{" "}
                    If you access external content via the app, we may collect
                    the referring URL and track areas you visit within our
                    services.
                  </p>
                </li>
                <li>
                  <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    <b className="lg:leading-[32px] leading-[28px]  text-m-base lg:text-base text-N400 font-bold">
                      Location Information:
                    </b>{" "}
                    With your consent, we may collect real-time geo-location
                    data through GPS, Wi-Fi networks, and other sensors. This
                    helps enhance app features, provide location-based services,
                    and improve your user experience.
                  </p>
                </li>
                <li>
                  <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                    <b className="lg:leading-[32px] leading-[28px]  text-m-base lg:text-base text-N400 font-bold">
                      Behavioral Analytics:
                    </b>{" "}
                    If you no longer desire to use the services on our services,
                    you may deactivate or delete your account by sending us an
                    email at support@milsat.tech Deactivating your account puts
                    your account on hold and is the same as telling you not to
                    delete any information because you might want to reactivate
                    your account at some point in the future. When you delete an
                    account, you are requesting that your account and the
                    information stored therein be permanently deleted from our
                    database. You should only delete your account if you are
                    sure you never want to reactivate it. Please note that
                    certain data you have provided may continue to exist in
                    aggregate form that cannot be used to identify you.
                  </p>
                </li>
              </ul>
            </section>
            <section>
              <h2 className="lg:leading-[32px] leading-[28px] text-m-base lg:text-base text-N400 font-bold ">
                Use of Cookies and Tracking Technologies
              </h2>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                We utilize various technologies to collect and store
                information, including cookies, device identifiers, and
                analytics tools. These help us:
              </p>
              <ul className="list-disc pl-40 my-[1rem]">
                <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  Improve services performance and user experience
                </li>
                <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  Deliver personalized content and recommendations
                </li>
                <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  Manage cookies and other tracking technologies
                </li>
              </ul>

              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                You can manage your tracking preferences via the cookie banner
                or within your device settings. However, disabling certain
                tracking features may affect app functionality.
              </p>
            </section>
            <section>
              <h3 className="lg:leading-[32px] leading-[28px] text-m-lg lg:text-lg text-N400 font-bold uppercase">
                Managing Your Information
              </h3>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                You have control over the data you share with us. You may:
              </p>
              <ul className="list-disc pl-40 my-[1rem]">
                <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  Adjust app permissions in your device settings
                </li>
                <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  Opt-out of location tracking (if applicable)
                </li>
                <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  Manage cookies and other tracking technologies
                </li>
              </ul>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                For more information on managing cookies, kindly visit{" "}
                <a
                  href="mailto:support@milsat.tech"
                  className="text-P300 "
                >
                  link
                </a>
              </p>
            </section>
            <section>
              <h3 className="lg:leading-[32px] leading-[28px] text-m-lg lg:text-lg text-N400 font-bold uppercase">
                Changes to This Privacy Policy
              </h3>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                We may update this policy periodically to reflect changes in
                technology, legal requirements, or our data practices. Any
                updates will be communicated to you through our services or
                other appropriate channels.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                If you have any questions regarding this policy, please contact
                us at{" "}
                <a
                  href="mailto:support@milsat.tech"
                  className="text-P300 "
                >
                  support@milsat.tech
                </a>
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                <b>Your rights:</b>
                You, as a data subject, have certain rights under the law. These
                include the right to:
              </p>
              <ul className="list-disc pl-40 my-[1.5rem]">
                <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  Access personal data we hold about you by making a request;
                </li>
                <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  rectify such information where you believe it to be incorrect
                  or inaccurate;
                </li>
                <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  restrict the processing of your data in certain circumstances;
                </li>
                <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  object to the processing of your data where we intend to
                  process such data for marketing purposes;
                </li>
                <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  request the erasure of your data (also known as the right to
                  be forgotten);
                </li>
                <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  withdraw your consent to the processing of your personal data;
                  and
                </li>
                <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  lodge a complaint with a relevant authority, where you have
                  reason to believe that we have violated the term(s) of this
                  Notice. (You may complain or seek redress from us within 30
                  days from the time you first detected the alleged violation.)
                </li>
              </ul>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                You may seek to exercise any of the above rights at any time by
                sending an email to us via{" "}
                <a
                  href="mailto:support@milsat.tech"
                  className="text-P300 "
                >
                  {" "}
                  support@milsat.tech{" "}
                </a>
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                The supervisory authority is the Nigerian Data Protection
                Commission(NDPC), and you can send your complaints via email to{" "}
                <a
                  href="mailto:info@ndpc.gov.ng"
                  className="text-P300 "
                >
                  info@ndpc.gov.ng{" "}
                </a>
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                <b>Marketing and Communication.</b>
                We only send marketing/newsletter communications to you with
                your consent. You may choose to opt out of our
                marketing/newsletter emails by clicking on the ‘unsubscribe'
                button at the bottom of the page.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                <b>Within Our Organization.</b> We may share any of your
                personal data with parents, subsidiaries, joint venture
                partners, and other entities under common control subject to
                this Privacy Policy.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                <b>Legal and Similar Disclosures.</b> We may disclose personal
                data about you to law enforcement, the courts, our advisors,
                attorneys, and others who participate in the legal process, if
                necessary to do so by law or based on our good-faith belief that
                it is necessary to enforce or apply our contracts, conform, or
                comply with the law or is necessary to protect us, the users of
                our services, or others.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                <b>Otherwise with Your Consent or At Your Direction.</b> We may
                update this privacy policy to reflect changes to our information
                practices. If we make any change in how we use personal data we
                will notify you by email (sent to the e-mail address specified
                in your account) or using a notice on our services before the
                change becomes effective. We encourage you to periodically
                review this page for the latest information on our privacy
                practices.
              </p>
            </section>
            <section>
              <h3 className="lg:leading-[32px] leading-[28px] text-m-lg lg:text-lg text-N400 font-bold uppercase">
                Security of Your Information
              </h3>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                We take steps to ensure that your information is handled
                securely and in accordance with this Privacy Policy. We use
                Encryption, Role-based Access and Two-Factor Authentication to
                ensure security of your personal data.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                Unfortunately, the Internet cannot be guaranteed to be 100%
                secure, and we cannot ensure or warrant the security of any
                information you provide to us. We do not accept liability for
                unintentional disclosure.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                By using our services or providing personal data to us, you
                agree that we may communicate with you electronically regarding
                security, privacy, and administrative issues relating to your
                use of the website. If we learn of a security system breach, we
                may attempt to notify you electronically by posting a notice on
                our services or by sending an email to you. You may have a legal
                right to receive this notice in writing. To receive free written
                notice of a security breach (or to withdraw your consent from
                receiving electronic notice), please notify us at{" "}
                <a
                  href="mailto:support@milsat.tech"
                  className="text-P300 "
                >
                  support@milsat.tech.
                </a>{" "}
              </p>
            </section>
            <section>
              <h3 className="lg:leading-[32px] leading-[28px] text-m-lg lg:text-lg text-N400 font-bold uppercase">
                Privacy of Children
              </h3>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                No one under the age of 18 is authorized to submit any
                information, including personal data, on our services. Under no
                circumstances may anyone under the age of 18 use the Service.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                If you learn that your child has provided us with personal data
                without your consent, you may alert us at{" "}
                <a
                  href="mailto:support@milsat.tech"
                  className="text-P300 "
                >
                  support@milsat.tech.
                </a>{" "}
                If we learn that we have collected any personal data from
                children under 18, we will promptly take steps to delete such
                information and terminate the child’s account.
              </p>
            </section>
            <section>
              <h3 className="lg:leading-[32px] leading-[28px] text-m-lg lg:text-lg text-N400 font-bold">
                Updating Your Information or Posing Questions or Suggestion
              </h3>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                If you have any questions or concerns about this Privacy Policy
                or the use of your information, or to modify or update any
                information we have received, please contact
                support@milsat.tech.
              </p>
              <div>
                <h2 className="lg:leading-[32px] leading-[28px]  text-m-base lg:text-base text-N400 font-bold">
                  Data Retention.
                </h2>
                <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  We implement industry-standard security measures, including
                  encryption, access controls, and regular audits, to protect
                  your data. While we take all necessary precautions, we
                  acknowledge that no online system is entirely secure. We
                  retain user data for as long as required to provide services
                  and comply with legal obligations.
                </p>
              </div>

              <div>
                <h2 className="lg:leading-[32px] leading-[28px]  text-m-base lg:text-base text-N400 font-bold ">
                  Account Deactivation and Deletion.
                </h2>
                <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  If you no longer desire to use the services on our services,
                  you may deactivate or delete your account by sending us an
                  email at support@milsat.tech Deactivating your account puts
                  your account on hold and is the same as telling you not to
                  delete any information because you might want to reactivate
                  your account at some point in the future. When you delete an
                  account, you are requesting that your account and the
                  information stored therein be permanently deleted from our
                  database. You should only delete your account if you are sure
                  you never want to reactivate it. Please note that certain data
                  you have provided may continue to exist in aggregate form that
                  cannot be used to identify you.
                </p>
              </div>
            </section>
            <section>
              <h3 className="lg:leading-[32px] leading-[28px] text-m-lg lg:text-lg text-N400 font-bold uppercase">
                Changes to Our Privacy Policy and Practices
              </h3>
              <p>
                <i className="py-2 lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  We may revise this Privacy Policy, so review it periodically.
                </i>
              </p>
              <div>
                <h2 className="lg:leading-[32px] leading-[28px]  text-m-base lg:text-base text-N400 font-bold">
                  Posting of Revised Privacy Policy.
                </h2>
                <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  We may update this privacy policy to reflect changes to our
                  information practices. If we make any change in how we use
                  personal data we will notify you by email (sent to the e-mail
                  address specified in your account) or using a notice on our
                  services before the change becomes effective. We encourage you
                  to periodically review this page for the latest information on
                  our privacy practices.
                </p>
              </div>
              <div>
                <h2 className="lg:leading-[32px] leading-[28px]   text-m-base lg:text-base text-N400 font-bold">
                  New Uses of personal data.
                </h2>
                <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  Occasionally, we may wish to use personal data for purposes
                  not previously disclosed in our Privacy Policy. If our
                  practices regarding previously collected personal data change
                  in a way that is materially less restrictive than stated in
                  the version of this Privacy Policy in effect at the time of
                  data collection, we will make reasonable efforts to provide
                  notice and obtain consent for any such uses as required by
                  law.
                </p>
              </div>
            </section>
          </main>
        </div>
        <Footer />
      </div>
    </>
  );
};

export default TermsConditionsPage;
