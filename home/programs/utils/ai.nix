{ ... }:
{
  home.shellAliases = {
  gemini = ''
    docker run --rm -it \
      --env-file /home/Sov/Zmyfile/Code/Docker/gemini-cli/.env \
      -v "$(pwd):/project" \
      localhost/gemini-cli
    '';
  };
}
