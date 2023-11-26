import Footer from "@/components/organism/Footer";
import Header from "@/components/organism/Header";
import { TAndCDetails } from "@/utils/data";
import blurEffectTopRight from "../../../Assets/blur-effect-top-right.svg";
import Link from "next/link";
import React from "react";
import Head from 'next/head'

const TermsConditionsPage = () => {
  return (
    <>
    <Head>
    <title>Terms and Condition</title>
      <meta name="description" content="Our Terms and Condition for Milsat Aspirant Programme" />
      <meta name="keywords" content="MAP, Aspirant Programmer, GIS Training, Milsat, Educaton, GIS Skills, GIS Mentorship, Esri,Fundalmental of GIS, Field Mapping, Data collection, Africa GIS, Data, learning GIS" />
      
      {/* Add a link to your favicon (replace 'favicon.ico' with your actual favicon) */}
      <link rel="icon" href="/favicon.ico" />

      {/* Add an Open Graph image (replace 'og-image.jpg' with your actual image)
      <meta property="og:image" content="/og-image.jpg" /> */}

      {/* Add a canonical URL if needed */}
      <link rel="canonical" href="https://aspirant.milsat.africa/apply/T&C" />

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
        <section className="w-full lg:my-[6%] my-[56px] lg:px-0 md:px-0 px-16">
          <h2 className="font-bold lg:text-xl text-m-xl lg:leading-[40px] leading-[30px] text-N400 text-center lg:mb-[88px] mb-[56px]">
            Terms of Service
          </h2>
          <div className="lg:w-[50%] w-full my-0 mx-auto space-y-24">
            <h2 className="lg:leading-[32px] leading-[28px] text-m-lg lg:text-lg text-N400 font-bold">
              Welcome to Milsat Aspirant!
            </h2>
            <div className="space-y-16">
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                Milsat Aspirant offers products and services provided by Milsat
                Technologies Limited and our affiliates and subsidiaries
                (collectively, “Milsat”, “us”, “we”, or “our”) These Terms of
                Service (‘Terms”) govern your use of our website, apps and other
                products and services (“Services”) and they constitute a binding
                agreement between you and Milsat Technologies Limited. “You”,
                “User” and “Users” shall mean all visitors to and users of the
                Milsat Aspirant services and products.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                Please read these Terms carefully before using the Milsant
                Aspirant Services By signing up and/or using any of our
                services, you agree to be bound by these Terms.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                By using any of our services provided, you acknowledge that you
                have read, understood and accepted the terms, conditions,
                notices and disclaimers contained in this document and in the
                Privacy Policy.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                Our products and services facilitate the integration of
                third-party services to enhance your experience. By utilizing
                services from third parties, you agree to be bound by and comply
                with their terms of service and policies.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                By engaging with the Mentor/Mentee feature provided on the
                Milsat Aspirant service, you also acknowledge and consent to the
                sharing of your information with your designated mentor or
                mentee, as applicable.
              </p>
            </div>
            <h2 className="lg:leading-[32px] leading-[28px] underline text-m-base lg:text-base text-N400 font-bold">
              WHO WE ARE?
            </h2>
            <div className="space-y-16">
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                Milsat Technologies Limited is a Data Acquisition as a service
                (DaaS) company focused on building location data collection
                tools, methodologies, and native analytical concepts
                specifically for the African ecosystem. Our service- Milsat
                Aspirant is a Geo-Spatial course learning platform for
                interested applicants to learn high-demand Geo-Spatial skills
                and become job-ready. For more information, please visit{" "}
                <Link href="https://milsat.africa/about-us/">
                  https://milsat.africa/about-us
                </Link>
              </p>
            </div>
            <h2 className="lg:leading-[32px] leading-[28px] text-m-lg lg:text-lg text-N400 font-bold">
              Using Milsat Aspirant
            </h2>
            <h2 className="lg:leading-[32px] leading-[28px] underline text-m-base lg:text-base text-N400 font-bold">
              WHO MAY USE OUR SERVICES?
            </h2>
            <div className="space-y-16">
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                Use or access by individuals under the age of 13 is strictly
                prohibited. Moreover, you are permitted to use our services only
                if you:
              </p>
              <ul className="list-disc pl-20">
                <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  Can enter into a legally binding contract with Milsat.
                </li>
                <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  Adhere to these Terms, all applicable laws, and our policies,
                  including the Privacy Policy, course-specific eligibility
                  requirements, and any other relevant policies.
                </li>
                <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  Are above the age required to consent to data processing under
                  the laws of your country. Additional requirements and age
                  restrictions may apply to certain regions and Content
                  Offerings.
                </li>
                <li className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                  Any breach of our Terms, applicable laws, or Policies may lead
                  to the suspension, disabling, or termination of your access to
                  all or part of the services.
                </li>
              </ul>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                When creating your Milsat Aspirant account and utilizing
                specific features, you must furnish accurate and complete
                information. Additionally, you agree to keep this information
                up-to-date to ensure its accuracy and completeness.
              </p>
            </div>
            <div>
              <h2 className="lg:leading-[32px] leading-[28px] underline text-m-base lg:text-base text-N400 font-bold">
                Our License to You:
              </h2>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                Subject to compliance with these Terms and our Policies, we
                grant you a limited, personal, non-exclusive, non-transferable,
                and revocable license to use our Services. The rights conferred
                herein are solely for your personal, non-commercial use, unless
                otherwise expressly permitted in writing by Milsat. You agree to
                create, access, and/or use only one user account unless
                explicitly allowed by Milsat, and you will not share access to
                your account or its information with any third party. The use of
                our Services does not confer upon you ownership or any
                intellectual property rights related to our Services or the
                content you access.
              </p>
            </div>
            <div>
              <h2 className="lg:leading-[32px] leading-[28px] underline text-m-base lg:text-base text-N400 font-bold">
                Commercial Use:
              </h2>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                The use of our Services for commercial purposes is strictly
                prohibited without a separate agreement with Milsat. For details
                on commercial use, please contact sales.
              </p>
            </div>

            <h3 className="lg:leading-[32px] leading-[28px] text-m-lg lg:text-lg text-N400 font-bold">
              Content Offerings
            </h3>
            <div>
              <h2 className="lg:leading-[32px] leading-[28px] underline text-m-base lg:text-base text-N400 font-bold">
                Changes To Content Offerings
              </h2>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                Milsat Aspirant offers courses and content ("Content Offerings")
                from various education platforms and other providers ("Content
                Providers"). While we seek to provide world-class Content
                Offerings from our Content Providers, unexpected events do
                occur. Milsat Aspirant reserves the right to cancel, interrupt,
                reschedule, or modify any Content Offerings, or change the point
                value or weight of any assignment, quiz, or other assessment,
                either solely, or in accordance with Content Provider
                instructions. Content Offerings are subject to the Disclaimers
                and Limitation of Liability sections below.
              </p>
            </div>
            <div>
              <h2 className="lg:leading-[32px] leading-[28px] underline text-m-base lg:text-base text-N400 font-bold">
                No Academic Credit:
              </h2>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                Milsat Aspirant does not provide academic credit for the
                successful completion of Content Offerings. Unless explicitly
                stated by an institution that grants academic credit,
                participation in or completion of Content Offerings does not
                result in the conferment of any academic credit. Even if one
                institution acknowledges credit, there is no assumption that
                other institutions will recognize or accept that credit. Milsat
                Aspirant, instructors, and affiliated Content Providers are not
                obligated to seek recognition of Content Offerings from any
                educational institution or accreditation organization.
              </p>
            </div>

            <h3 className="lg:leading-[32px] leading-[28px] text-m-lg lg:text-lg text-N400 font-bold">
              Your Content
            </h3>
            <div>
              <h2 className="lg:leading-[32px] leading-[28px] underline text-m-base lg:text-base text-N400 font-bold">
                User Content
              </h2>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                The Services enable you to share your content, such as homework,
                exams, projects, other assignments you submit, posts you make in
                the forums, and the like ("User Content"), with Milsat Aspirant,
                Instructors, Mentors, Mentees and/or other users. You retain all
                intellectual property rights in, and are responsible for, the
                User Content you create and share. User Content does not include
                course content or other materials made available on or placed on
                to the Milsat Aspirant platform by or on behalf of Content
                Providers or their instructors using the Services or Content
                Offerings. As between Milsat Aspirant and Content Providers,
                such Content Offerings are governed by the relevant agreements
                in place between Milsat Aspirant and Content Providers.
              </p>
            </div>
            <div>
              <h2 className="lg:leading-[32px] leading-[28px] underline text-m-base lg:text-base text-N400 font-bold">
                How Milsat Aspirant and Others May Use User Content
              </h2>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                To the extent that you provide User Content, you grant Milsat
                Aspirant a fully-transferable, royalty-free, perpetual,
                sublicensable, non-exclusive, worldwide license to copy,
                distribute, modify, create derivative works based on, publicly
                perform, publicly display, and otherwise use the User Content.
                This license includes granting Milsat Aspirant the right to
                authorize Content Providers to use User Content with their
                registered students, on-campus learners, or other learners
                independent of the Services. Nothing in these Terms shall
                restrict other legal rights Milsat Aspirant may have to User
                Content, for example under other licenses. We reserve the right
                to remove or modify User Content for any reason, including User
                Content that we believe violates these Terms or other policies.
              </p>
            </div>
            <div>
              <h2 className="lg:leading-[32px] leading-[28px] underline text-m-base lg:text-base text-N400 font-bold">
                Modifying or Terminating our Services
              </h2>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                We are constantly changing and improving our Services. We may
                add or remove functions, features, or requirements, and we may
                suspend (to the extent allowed by applicable law) or stop part
                of our Services altogether. Accordingly, Milsat Aspirant may
                terminate your use of any Service for any reason. If your use of
                a paid Service is terminated, a refund may be available under
                our Refund Policy. We may not be able to deliver the Services to
                certain regions or countries for various reasons, including due
                to applicable export control requirements or internet access
                limitations and restrictions from governments. None of Milsat
                Aspirant, its Content Providers and instructors, its
                contributors, sponsors, and other business partners, and their
                employees, contractors, and other agents (the "Milsat Aspirant
                Parties") shall have any liability to you for any such action.
                You can stop using our Services at any time, although we'll be
                sorry to see you go.
              </p>
            </div>
            <div>
              <h2 className="lg:leading-[32px] leading-[28px] underline text-m-base lg:text-base text-N400 font-bold">
                Disclaimers
              </h2>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                To the maximum extent permitted by law, the services and all
                included content are provided on an "as is" basis without
                warranty of any kind, whether express or implied. The Milsat
                Aspirant parties specifically disclaim any and all warranties
                and conditions of merchantability, fitness for a particular
                purpose, and non-infringement, and any warranties arising out of
                course of dealing or usage of trade. The Milsat Aspirant parties
                further disclaim any and all liability related to your access or
                use of the services or any related content. You acknowledge and
                agree that any access to or use of the services or such content
                is at your own risk.
              </p>
            </div>
            <div>
              <h2 className="lg:leading-[32px] leading-[28px] underline text-m-base lg:text-base text-N400 font-bold">
                Limitation of Liability
              </h2>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                To the maximum extent permitted by law, the Milsat Aspirant
                parties shall not be liable for any indirect, incidental,
                special, consequential, or punitive damages, or any loss of
                profits or revenues, whether incurred directly or indirectly, or
                any loss of data, use, goodwill, or other intangible losses,
                resulting from: (a) your access to or use of or inability to
                access or use the services; (b) any conduct or content of any
                party other than the applicable Milsat Aspirant party, including
                without limitation, any defamatory, offensive, or illegal
                conduct; or (c) unauthorized access, use, or alteration of your
                content or information. In no event shall Milsat Aspirant's
                aggregate liability for all claims related to the services
                exceed the total amount of fees received by Milsat Aspirant from
                you for the use of paid services during the past six months.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                You acknowledge and agree that the disclaimers and the
                limitations of liability set forth in this terms of use reflect
                a reasonable and fair allocation of risk between you and the
                Milsat Aspirant parties, and that these limitations are an
                essential basis to Milsat Aspirant's ability to make the
                services available to you on an economically feasible basis.
              </p>
            </div>
            <div>
              <h2 className="lg:leading-[32px] leading-[28px] underline text-m-base lg:text-base text-N400 font-bold">
                Indemnification
              </h2>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                You agree to indemnify, defend, and hold harmless the Milsat
                Aspirant Parties from any and all claims, liabilities, expenses,
                and damages (to the extent attributable to you under the
                applicable law), including reasonable attorneys' fees and costs,
                made by any third party related to: (a) your use or attempted
                use of the Services in violation of these Terms; (b) your
                violation of any law or rights of any third party; or (c) User
                Content, including without limitation any claim of infringement
                or misappropriation of intellectual property or other
                proprietary rights.
              </p>
            </div>
            <div>
              <h2 className="lg:leading-[32px] leading-[28px] underline text-m-base lg:text-base text-N400 font-bold">
                Dispute Resolution:
              </h2>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                In the event of any dispute, claim, or controversy arising from
                or relating to these Terms or your use of our services (referred
                to collectively as a "Dispute"), the parties commit to engaging
                in good faith negotiations to resolve the Dispute. Either party
                may initiate negotiations by delivering written notice to the
                other party, clearly outlining the nature of the Dispute and the
                desired relief.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                Should the parties be unable to reach a resolution through
                negotiation within a reasonable timeframe, they agree to
                escalate the matter to mediation. The mediation process will be
                overseen by a neutral mediator, whose selection is to be
                mutually agreed upon by both parties.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                If mediation fails to bring about a resolution of the Dispute,
                the parties further agree to submit the matter to binding
                arbitration. The arbitration proceedings will adhere to the
                guidelines set forth in the Arbitration and Mediation Act of
                2023. The arbitration itself will occur in Nigeria, and English
                Language shall be the designated language for the proceedings.
                The award determined by the arbitrator(s) will be deemed final
                and binding upon both parties, and enforcement of the award may
                be sought in any court of competent jurisdiction.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                Notwithstanding the arbitration requirement, either party may
                seek injunctive relief in a court of law in cases of
                intellectual property infringement, violation of
                confidentiality, or any other violation of the party's rights
                that may cause irreparable harm.
              </p>
            </div>
            <div>
              <h2 className="lg:leading-[32px] leading-[28px] underline text-m-base lg:text-base text-N400 font-bold">
                Governing Law and Venue
              </h2>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                Except as provided below, the Services are managed by Milsat
                Technologies Limited which is located in Abuja, Nigeria. You
                agree that these Terms will be governed by the laws of the
                Federal Republic of Nigeria, excluding its conflicts of law
                provisions. In the event of any dispute related to these Terms
                that is not subject to binding arbitration, you and Milsat will
                submit to the personal jurisdiction of the federal and state
                courts located in and serving the Federal Capital Territory,
                Abuja as the legal forum for any such dispute.
              </p>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                This section shall not deprive you of any mandatory consumer
                protections under the law of the country to which we direct
                Services to you, where you have your habitual residence.
              </p>
            </div>
            <h3 className="lg:leading-[32px] leading-[28px] text-m-lg lg:text-lg text-N400 font-bold">
              General Terms
            </h3>
            <div>
              <h2 className="lg:leading-[32px] leading-[28px] underline text-m-base lg:text-base text-N400 font-bold">
                Revisions to the Terms
              </h2>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                We reserve the right to revise the Terms at our sole discretion
                at any time. Any revisions to the Terms will be effective
                immediately upon posting by us. For any material changes to the
                Terms, we will take reasonable steps to notify you of such
                changes, via a banner on the website, email notification,
                another method, or combination of methods. In all cases, your
                continued use of the Services after publication of such changes,
                with or without notification, constitutes binding acceptance of
                the revised Terms.
              </p>
            </div>
            <div>
              <h2 className="lg:leading-[32px] leading-[28px] underline  text-m-base lg:text-base text-N400 font-bold">
                Severability; Waiver
              </h2>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                If it turns out that a particular provision of these Terms is
                not enforceable, this will not affect any other terms. If you do
                not comply with these Terms, and we do not take immediate
                action, this does not indicate that we relinquish any rights
                that we may have (such as taking action in the future).
              </p>
            </div>
            <div>
              <h2 className="lg:leading-[32px] leading-[28px] underline text-m-base lg:text-base text-N400 font-bold">
                Content Providers
              </h2>
              <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">
                Our Content Providers and integrated service providers are third
                party beneficiaries of the Terms and may enforce those
                provisions of the Terms that relate to them.
              </p>
            </div>
          </div>
        </section>
      </div>
      <Footer />
    </div>
    </>
  );
};

export default TermsConditionsPage;
