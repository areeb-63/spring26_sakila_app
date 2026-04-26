import os

# Authors: Abdul Raffay Qasim, Urwah Taj, Aliyah Cheema
# Date: 2026-04-23
# Purpose: Database and health check configuration for Sakila Flask Application
# Notes: Merged improvements from feature/add-healthcheck after PR review


class Config:
    """Base configuration class for the Sakila Flask application.
    Handles database connection strings and system timeouts.
    """
    MYSQL_HOST = os.environ.get('MYSQL_HOST', 'sakila-db-server')
    MYSQL_USER = os.environ.get('MYSQL_USER', 'root')
    MYSQL_PASSWORD = os.environ.get('MYSQL_PASSWORD', 'admin')
    MYSQL_DB = os.environ.get('MYSQL_DB', 'sakila')
    SECRET_KEY = os.environ.get('SECRET_KEY', 'your-secret-key-here-change-this-in-production')

    CONNECTION_TIMEOUT = int(os.environ.get('CONNECTION_TIMEOUT', '30'))
    HEALTH_CHECK_INTERVAL = int(os.environ.get('HEALTH_CHECK_INTERVAL', '10'))
