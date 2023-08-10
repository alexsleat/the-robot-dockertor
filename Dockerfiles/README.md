
## Dockerfile tips and best practices:

### Each line creates a new layer:
This is an important note, as each line creates a new layer in the image. 
- This can be useful during the initial building, as unchanged layers above your changes will not need to be rebuilt.
- This can be detrimental by creating too many layers for tasks such as installing packages. You can use "space backslash" ( \\) to extend over multiple lines for example:
  -     RUN apt-get install -y pkg1 pkg2 \
          pkg3 pkg4 
- Some actions will need to be performed on one line - for example, if you want to navigate to a file and run it, doing this over 2 lines would result in failure. Instead, do something like:
  -     RUN cd /file/path && chmod +x file_name.sh && ./file_name.sh

### Do NOT store secrets in the Dockerfile:
Do not add API keys, db passwords, etc.

#### Build Arguments:

Dockerfile:

    # Define the argument
    ARG EXAMPLE_ARG
    # Set it as an environment variable inside the container with the name "APP_ENV"
    ENV APP_ENV=${EXAMPLE_ARG}

Build command:
    
    docker build --build-arg EXAMPLE_ARG=someargument .

#### Runtime Args:
Setting env variables in the container at runtime:

    docker run --env EXAMPLE_ARG=someargument container_name

## Dockerfile example one-liners:

### Running an installation script with user input:
In the following example, "install_script.sh" is run, with the user inputs for 7 questions.
Answers must be followed by a newline (\n) to submit the response.

    printf "y\ny\ndocker\ny\ny\ny\ny" | ./install_script.sh
