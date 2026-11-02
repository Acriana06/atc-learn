# ATC Learn 

**ATC Learn** is an advanced, interactive training and revision terminal developed by **Acrosia Tamrat** to support Air Traffic Control trainees at the **Ethiopian Civil Aviation Authority (ECAA)**.

The platform is built strictly in alignment with International Civil Aviation Organization (ICAO) standards and Doc 4444 rules, providing trainees with structured curriculum tracks, AI-assisted study guidance, dynamic quizzes, and real-time performance analytics.

## Submission Details
* **1. GitHub Repository Link:** [Insert your GitHub repository URL here]
* **2. Video Presentation:** [Insert your Google Drive shareable link here - make sure sharing is set to "Anyone with the link can view"]
* **3. Team Information:**
  * **Acrosia Tamrat** | CTC ID: CTC-1795-26

## Features & Screens

- **Authentication Gate & Login (`views/auth/`):** Stream-based login and session handling via Supabase Auth state listening.
- **Home Screen (`views/home/`):** Primary trainee landing hub displaying active study tracks, session shortcuts, and feature navigation.
- **ICAO Course Curriculum (`views/modules/`):** Modular learning tracks covering Basic ATS, Aerodrome Control, Approach Control, and Area Control (CRS-01 through CRS-09), served locally for zero latency.
- **AI ATC Study Assistant (`views/ai_tutor/`):** Integrated AI study companion powered by serverless Deno Edge Functions, grounded in ICAO separation rules and phraseology.
- **Dynamic Quizzes & Assessments (`views/quiz/`):** Multi-question tests with instant score computation, database saving, and automated evaluation generation via Edge Functions.
- **Trainee Progress & Metrics Dashboard (`views/analytics/`):** Real-time course-level metric aggregation, proficiency gauges, and progress bars recording quiz results and scores.
- **Profile Screen (`views/profile/`):** Displays cadet credentials, CTC ID details, course enrollment status, and training history.
- **Settings Screen & Theme Adaptability (`views/settings/`):** Manages app preferences, local storage, and seamless Light/Radar Dark mode toggles optimized for operational training environments.
## Technology Stack

- **Frontend:** Flutter (Web & Android)
- **Architecture & State Management:** Clean Architecture folder structure with Provider Pattern
- **Backend & Database:** Supabase (PostgreSQL, Row Level Security)
- **Serverless Logic:** Supabase Edge Functions (AI Integration & Quiz Generation)
- **Version Control:** Git

## Project Status

**Version 2.0 (Production Release):** Fully implemented, schema-optimized, and verified with successful web and mobile release builds.

## Disclaimer

This application is a training and revision support tool for ECAA trainees. It is not intended for live air traffic control operations or official certification assessment.
