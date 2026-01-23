# Nonstop App Policy & Terms Guide (Uzbekistan Target)

## 1. Overview
This document outlines the necessary legal policy documents and implementation guidelines for 'Nonstop', a community app targeting university students in Uzbekistan. It is designed to comply with local Uzbek regulations (e.g., Personal Data Protection laws) and cultural nuances.

## 2. Mandatory Policy Documents
Users **must agree (Check)** to these items during sign-up to use the service.

### A. Terms of Service (ToS)
- **Purpose**: Establishes the legal contract between the company and the user.
- **Key Contents**:
  - **Account Policy**: One account per person, mandatory student verification via university email.
  - **Prohibition of Account Transfer**: Strictly forbidding the sale or rental of accounts to others.
  - **Limitation of Liability (Disclaimer)**:
    - The platform maintains technical neutrality regarding disputes between users on anonymous boards and is not legally liable.
    - Possibility of service interruption due to server maintenance, natural disasters, or local telecommunication issues.
  - **Jurisdiction**: Designation of governing law and jurisdiction for disputes (e.g., Tashkent Court, Uzbekistan).

### B. Privacy Policy
- **Purpose**: Ensures transparency regarding the collection, use, storage, and destruction of user's personal data.
- **Key Contents (Compliance with Uzbekistan ZRU-547)**:
  - **Collection Items**:
    - Mandatory: Email, Password (encrypted), Nickname, University Name, Major, Student ID (optional/mandatory), Device ID.
    - Automatic: Access logs, cookies, IP address.
  - **Purpose of Collection**: Identity verification (student authentication), prevention of duplicate sign-ups, blocking malicious users.
  - **Retention & Destruction**: Principle of immediate destruction upon account deletion (Note: logs may be kept for 3 months to 1 year as required by law).
  - **Third-party Provision**:
    - **Law Enforcement Cooperation**: Mentioning the possibility of providing minimal information for criminal investigations (terrorism, drugs, etc.) upon presentation of a warrant by Uzbek law enforcement.
  - **Data Location**: Specification of server location (local Uzbek servers recommended; if overseas, explicit consent for cross-border transfer is required).

### C. Community Guidelines
- **Purpose**: Maintains a healthy anonymous community and prevents legal risks.
- **Key Contents**:
  - **Prohibited Content**: Profanity, obscenity, defamation, hate speech, gambling/illegal advertisements.
  - **Uzbekistan-Specific Precautions**:
    - **Prohibition of Political/Religious Incitement**: Strong sanctions are necessary as these are highly sensitive topics locally.
    - **National Security Threats**: Strict prohibition of even joking about terrorism or state subversion (risk of service shutdown).
  - **Academic Violations**: Prohibition of illegal acts such as proxy attendance, exam cheating, or selling "jokbo" (past exam papers).
  - **Reporting & Sanctions**: Standards for automatic blinding and banning based on accumulated reports.

## 3. Optional Policy Documents
Items that users can choose not to agree to while still being able to sign up.

### A. Marketing Consent
- **Content**: Consent for receiving push notifications for events, affiliate benefits, and advertisements.
- **Implementation**: Recommended as `Unchecked` by default during sign-up (Opt-in method).

## 4. Uzbekistan Localization Checklist

### 1) Data Localization
- **Issue**: Uzbek Personal Data Protection law may require storing data of Uzbek citizens on **servers located within the territory of Uzbekistan**.
- **Response**:
  - Initial: If using global clouds (AWS/Google), the policy must explicitly state that "data may be transferred and stored outside of Uzbekistan (e.g., Korea, Germany)" and obtain consent.
  - Long-term: Consider using local IDCs like Uztelecom.

### 2) Language
- Policies should be provided in both **Uzbek (Latin script)** and **Russian** for legal validity.
- English is provided as a reference.

### 3) Identity Verification
- Since Uzbekistan uses passport information for SIM card registration, introducing SMS verification can have the effect of de facto real-name verification (consider for future implementation).

## 5. Sign-up Screen UI Implementation Guide

The following checkbox list should be placed directly above the `Sign Up` button.

```text
[ ] (Required) I agree to the Terms of Service. [View >]
[ ] (Required) I agree to the Collection and Use of Personal Information. [View >]
[ ] (Required) I agree to comply with the Community Guidelines. [View >]
[ ] (Required) I am 14 years of age or older.
[ ] (Optional) I agree to receive event and marketing notifications.
```

- If any `(Required)` item is unchecked, the sign-up button must be disabled.
- Tapping `[View >]` should display the full text of the respective policy in a popup or a new page.

## 6. Reason for Age Requirement (14+)
Requiring consent for "14 years of age or older" in a university community app is to prevent the following legal and operational risks:

### 1) Ensuring Legal Validity of Personal Information Collection
- **Avoiding Parental Consent**: Under Uzbek and global data protection laws, collecting information from children under 14 requires parental consent. This item is a legal declaration to operate the service without complex parental verification procedures.
- **Recognition of Consent Capacity**: Individuals 14 and older are generally considered to have the legal capacity to judge and consent to providing their personal information.

### 2) Child Protection Obligations & Limitation of Liability
- **Prevention of Exposure to Inappropriate Content**: The platform has a legal obligation to protect children from adult-oriented conversations or harsh language within the community.
- **Basis for Disclaimer**: By specifying the age limit and obtaining user confirmation, the operator can minimize liability if a child signs up by providing false information.

### 3) Compliance with Global App Store Policies
- **Approval Process**: Google Play and Apple App Store apply extremely strict standards (ad restrictions, no tracking, etc.) to apps targeting children. Explicitly stating the 14+ limit allows the app to be classified as a 'General Audience App', ensuring stable service provision.
