# ai_dev_tools_zcamp
Following Module 1 of DataTalksClub course - https://datatalks.club/courses/ai-dev-tools-zoomcamp/

## Django project setup

This repo includes a Django project scaffold named `zcamp`.

### Prerequisites

- Python 3.10+
- GitHub Codespaces or a local environment (Linux/macOS/WSL recommended)

### Quick start

1. Create and activate a virtual environment:

	```bash
	python3 -m venv .venv
	source .venv/bin/activate
	```

2. Install dependencies:

	```bash
	pip install -r requirements.txt
	```

3. Run Django checks and start the development server:

	```bash
	cd zcamp
	python manage.py check
	python manage.py runserver 0.0.0.0:8000
	```

4. Open your browser at:

	- http://localhost:8000 (locally)
	- In Codespaces, use the Ports tab or the forwarded URL.

### Notes

- Dependencies are pinned in `requirements.txt`.
- The virtual environment folder `.venv/` is ignored by Git.
- VS Code typically auto-detects `.venv`; if not, select the interpreter via:
  `Ctrl+Shift+P` → "Python: Select Interpreter" → `.venv/bin/python`.

## Production readiness notes

This project is scaffolded for quick prototyping. A few changes have been applied to make a small-production deployment easier:

- Settings now support environment variables:
  - `DJANGO_SECRET_KEY` — secret key (defaults to the dev key if not set).
  - `DJANGO_DEBUG` — set to `False` in production.
  - `DJANGO_ALLOWED_HOSTS` — comma-separated hosts for `ALLOWED_HOSTS`.
- Static files are configured for WhiteNoise (`STATIC_ROOT` set and `whitenoise` middleware enabled).
- Production dependencies added: `whitenoise`, `gunicorn` (see `requirements.txt`).

Basic deploy checklist:

1. Set environment variables (SECRET_KEY, DEBUG=False, ALLOWED_HOSTS).
2. Install dependencies and collect static files:

	```bash
	pip install -r requirements.txt
	python manage.py migrate
	python manage.py collectstatic --noinput
	```

3. Run with Gunicorn behind your preferred process manager / container:

	```bash
	gunicorn zcamp.wsgi:application --bind 0.0.0.0:8000 --workers 3
	```

4. Add HTTPS / reverse proxy (nginx) and proper logging in front of Gunicorn for production.

Limitations and next steps for production readiness

- SQLite is still the default DB; use Postgres or another production-grade DB for real deployments.
- Add secure settings (HSTS, SESSION_COOKIE_SECURE, CSRF_COOKIE_SECURE) when serving over HTTPS.
- Add CI and automated tests and a backup/monitoring strategy.

## Docker and Nginx (sample)

This repo includes a simple `Dockerfile`, `docker-compose.yml`, an `entrypoint.sh`, and a sample nginx config under `deploy/nginx.conf` for local testing and small deployments.

Quick start with docker-compose (development-like):

1. Copy the sample env file and edit values:

	```bash
	cp .env.sample .env
	# edit .env to set DJANGO_SECRET_KEY and DJANGO_DEBUG
	```

2. Build and run:

	```bash
	docker compose up --build
	```

3. The app will be available at http://localhost (nginx on port 80) and static files are served by nginx.

Notes:
- The docker-compose file defines a `static` service which runs `collectstatic` and shares the files into an nginx static volume. This is simplified for local testing.
- Do not store secrets in repository; use a secrets manager or environment variables in production.



