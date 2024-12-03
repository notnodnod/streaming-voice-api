install:
    # Install the virtual environment and install the pre-commit hooks
    echo "🚀 Creating virtual environment using uv"
    uv sync
    uv run pre-commit install

check:
    # Run code quality tools
    echo "🚀 Checking lock file consistency with 'pyproject.toml'"
    uv lock --locked
    echo "🚀 Linting code: Running pre-commit"
    uv run pre-commit run -a
    echo "🚀 Static type checking: Running mypy"
    uv run mypy
    echo "🚀 Checking for obsolete dependencies: Running deptry"
    uv run deptry .

test:
    # Test the code with pytest
    echo "🚀 Testing code: Running pytest"
    uv run python -m pytest --cov --cov-config=pyproject.toml --cov-report=xml

build: clean-build
    # Build wheel file
    echo "🚀 Creating wheel file"
    uvx --from build pyproject-build --installer uv

clean-build:
    # Clean build artifacts
    echo "🚀 Removing build artifacts"
    uv run python -c "import shutil; import os; shutil.rmtree('dist') if os.path.exists('dist') else None"

docs-test:
    # Test if documentation can be built without warnings or errors
    uv run mkdocs build -s

docs:
    # Build and serve the documentation
    uv run mkdocs serve

help:
    # Display available recipes and descriptions
    @just --list
