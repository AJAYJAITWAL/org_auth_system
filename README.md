# 🏢 Organization Auth System

A Ruby on Rails application built from scratch with:

- ✅ Custom authentication (no Devise)
- ✅ Organization and user-based access control
- ✅ Role-based authorization (`admin` / `member`)
- ✅ Age-based participation rules
- ✅ Parental consent required for minors
- ✅ Full model and logic test coverage using RSpec

---

## 📦 Tech Stack

- **Ruby** 3.3.3
- **Rails** 7.x
- **PostgreSQL** as the database
- **RSpec** for testing
- **FactoryBot**, **Shoulda-Matchers** for cleaner test writing

---

## ✨ Key Features

### 🔐 Custom Authentication
- Built-in from scratch (no Devise or external auth gem)
- Simple user login/logout logic (optional controller implementation)

### 🧍 User Access & Validation
- Users have:
  - `date_of_birth` (required)
  - `parental_consent_given` boolean (for minors)
- Automatic `age` calculation
- `minor?` and `parental_consent_given?` helpers

### 🏢 Organization Membership
- Users can join multiple organizations
- Memberships have roles:
  - `admin`: manages org
  - `member`: regular user
- Users are assigned to organizations through a `Membership` model

### 🛡️ Role-Based Access Control
- Defined via `enum` in Membership
- Use scopes like `.admin` to fetch admin users

### 🧒 Parental Consent Logic
- Users under 18 (`minor? == true`) must have `parental_consent_given: true`
- Adults (18+) automatically considered to have consent

### 🧪 RSpec Tests
- Tests written for:
  - Age calculation
  - Minor detection
  - Parental consent rules
  - Membership role scopes
  - Model associations

---

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/org_auth_system.git
cd org_auth_system
```

### 2. Install Gems
```bash
bundle install
```

### 3. Setup the Database
```bash
rails db:create
rails db:migrate
```

### 4. Run the Test Suite
```bash
bundle exec rspec
```

### 5. Run the Server
```bash
rails server
```
