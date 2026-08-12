# ⛩️ FengShui-Shifu API (`fengshui-shifu-api`)

Ruby on Rails 8 API backend for **FengShui-Shifu (风水师傅)** — AI Spatial Feng Shui & BaZi Fortune Telling Platform.

---

## 🚀 Quick Start (Local Development)

### Option A: Running with Docker (Recommended)
```bash
# Start Rails API + PostgreSQL database
docker-compose up --build
```
The API will be available at `http://localhost:3000`.

### Option B: Running Natively
```bash
# Install gems
bundle install

# Run RSpec tests
bundle exec rspec

# Start Rails server
bin/rails server
```

---

## 📡 API Endpoints

### 1. Health Check
* **GET** `/api/v1/health`
* **Response:**
```json
{
  "status": "ok",
  "service": "fengshui-shifu-api",
  "timestamp": "2026-08-12T11:00:00Z"
}
```

### 2. Instant BaZi Calculator (Guest / Free Tier)
* **POST** `/api/v1/bazi/calculate`
* **Body:**
```json
{
  "birth_date": "1990-01-01",
  "gender": "male"
}
```
* **Response:**
```json
{
  "success": true,
  "data": {
    "birth_date": "1990-01-01",
    "gender": "male",
    "day_master": {
      "name": "Ren Water",
      "chinese": "壬水",
      "element": "Water",
      "polarity": "Yang"
    },
    "kua_number": 7,
    "kua_profile": {
      "group": "West",
      "sheng_qi": "NW",
      "tian_yi": "SW",
      "yan_nian": "NE",
      "fu_wei": "W"
    },
    "today_luck_teaser": "Today's Energy Rating for Water Day Masters: 92% High Potential."
  }
}
```

---

## 🧪 Running RSpec Tests
```bash
bundle exec rspec
```

---

## 🔄 CI/CD Pipeline
GitHub Actions automatically runs RSpec tests and builds the production Docker container on every push to `main`.
