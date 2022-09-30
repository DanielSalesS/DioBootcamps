from setuptools import setup, find_packages

with open("README.md", "r") as f:
    page_description = f.read()

with open("requirements.txt") as f:
    requirements = f.read().splitlines()

setup(
    name="dio_image_processing",
    version="0.0.1",
    author="Daniel Sales Santos",
    author_email="danielsales@testemail.com",
    description="A simple image processing package",
    long_description=page_description,
    long_description_content_type="text/markdown",
    url="https://github.com/DanielSalesS/dio_image_processing",
    packages=find_packages(),
    install_requires=requirements,
    python_requires='>=3.8',
)
