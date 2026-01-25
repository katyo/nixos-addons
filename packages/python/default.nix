pySelf: pySuper: with { inherit (pySelf) callPackage; }; {
  mcp = callPackage ../mcp-servers/mcp {};

  spandrel = callPackage ./spandrel {};
  pycocoevalcap = callPackage ./pycocoevalcap {};
  segment-anything = callPackage ./segment-anything {};
  groundingdino = callPackage ./groundingdino {};
  transparent-background = callPackage ./transparent-background {};
  supervision = callPackage ./supervision {};
  supervision_06 = callPackage ./supervision/0.6.nix {};
  mediapipe = callPackage ./mediapipe {};
  clip-interrogator = callPackage ./clip-interrogator {};
  colour-science = callPackage ./colour-science {};
  pixeloe = callPackage ./pixeloe {};
  color-matcher = callPackage ./color-matcher {};
  blend-modes = callPackage ./blend-modes {};
  argbind = callPackage ./argbind {};
  randomname = callPackage ./randomname {};
  pyloudnorm = callPackage ./pyloudnorm {};
  pystoi = callPackage ./pystoi {};
  torch-stoi = callPackage ./torch-stoi {};
  descript-audiotools = callPackage ./descript-audiotools {};
  descript-audio-codec = callPackage ./descript-audio-codec {};
  pysox = callPackage ./pysox {};
  silentcipher = callPackage ./silentcipher {};
  torch-complex = callPackage ./torch-complex {};
  pilgram = callPackage ./pilgram {};
  chkpkg = callPackage ./chkpkg {};
  cstr = callPackage ./cstr {};
  img2texture = callPackage ./img2texture {};
  blind-watermark = callPackage ./blind-watermark {};
  typer-config = callPackage ./typer-config {};
  evalidate = callPackage ./evalidate {};
  poetry-plugin-pypi-mirror = callPackage ./poetry-plugin-pypi-mirror {};
  zhipuai = callPackage ./zhipuai {};
  came-pytorch = callPackage ./came-pytorch {};
  pymatting = pySuper.pymatting.overrideAttrs (old: { disabledTests = ["test_foreground"]; });

  uroman = callPackage ./uroman {};
  outetts = callPackage ./outetts {};

  demucs = callPackage ./demucs {};
  dora-search = callPackage ./dora-search {};
  lameenc = callPackage ./lameenc {};
  openunmix = callPackage ./openunmix {};
  treetable = callPackage ./treetable {};
  pedalboard = callPackage ./pedalboard {};

  starlette-compress = callPackage ./starlette-compress {};

  cached-path = callPackage ./cached-path {};
  ema-pytorch = callPackage ./ema-pytorch {};
  rjieba = callPackage ./rjieba {};
  transformers-stream-generator = callPackage ./transformers-stream-generator {};
  vocos = callPackage ./vocos {};
  ruaccent = callPackage ./ruaccent {};
  f5-tts = callPackage ./f5-tts { gradio = pySelf.gradio-6; };

  dadaptation = callPackage ./dadaptation {};
  lycoris-lora = callPackage ./lycoris-lora {};
  prodigyopt = callPackage ./prodigyopt {};
  prodigy-plus-schedule-free = callPackage ./prodigy-plus-schedule-free {};
  pytorch-optimizer = callPackage ./pytorch-optimizer {};
  schedulefree = callPackage ./schedulefree {};
  tk = callPackage ./tk {};

  gradio-fixed = pySuper.gradio.overrideAttrs (old: { disabledTests = old.disabledTests ++ [
    "test_gradio_mcp_server_initialization"
    "test_get_executable_path"
    "test_get_block_fn_from_tool_name"
    "test_generate_tool_names_correctly_for_interfaces"
    "test_convert_strings_to_filedata"
    "test_postprocess_output_data"
    "test_simplify_filedata_schema"
    "test_tool_prefix_character_replacement"
    "test_associative_keyword_in_schema"
    "test_tool_selection_via_query_params"
    "test_download_if_url_correct_parse"
  ]; });
  mcp-1_25 = callPackage ./mcp {};
  gradio-6-client = callPackage ./gradio/client.nix { gradio = pySelf.gradio-6; };
  gradio-6 = callPackage ./gradio (with pySelf; {
    gradio = gradio-6;
    gradio-client = gradio-6-client;
    mcp = mcp-1_25;
  });

  # CadQuery & build123d
  #nlopt = callPackage ./cadquery/nlopt.nix {};
  #casadi = callPackage ./cadquery/casadi-whl.nix {};
  #ezdxf1 = callPackage ./cadquery/ezdxf.nix {};
  #multimethod1 = callPackage ./cadquery/multimethod.nix {};

  #svgpathtools = callPackage ./cadquery/svgpathtools.nix {};
  pylib3mf = callPackage ./cadquery/pylib3mf.nix {};
  ocpsvg = callPackage ./cadquery/ocpsvg.nix {};
  trianglesolver = callPackage ./cadquery/trianglesolver.nix {};
  ocp-tessellate = callPackage ./cadquery/ocp-tessellate.nix {};

  cadquery-ocp = callPackage ./cadquery/cadquery_ocp-whl.nix {};
  cadquery-vtk = callPackage ./cadquery/cadquery_vtk-whl.nix {};

  cadquery = callPackage ./cadquery {};

  cq-warehouse = callPackage ./cadquery/cq-warehouse.nix {};
  cq-gears = callPackage ./cadquery/cq-gears.nix {};
  cq-kit = callPackage ./cadquery/cq-kit.nix {};
  cq-cache = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "cq_cache"; };
  cq-apply-to-each-face = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "apply_to_each_face"; };
  cq-fragment = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "fragment"; };
  cq-freecad-import = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "freecad_import"; };
  cq-gear-generator = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "gear_generator"; };
  cq-heatserts = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "heatserts"; };
  cq-local-selectors = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "localselectors"; };
  cq-more-selectors = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "more_selectors"; };
  cq-sample-plugin = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "sampleplugin"; };
  cq-teardrop = callPackage ./cadquery/cq-plugins.nix { cqPlugin = "teardrop"; };

  build123d = callPackage ./cadquery/build123d.nix {};

  bd-warehouse = callPackage ./cadquery/bd-warehouse.nix {};

  voila = callPackage ./cadquery/voila-whl.nix {};
  numpy-quaternion = callPackage ./cadquery/numpy-quaternion.nix {};
  cad-viewer-widget = callPackage ./cadquery/cad-viewer-widget-whl.nix {};

  jupyter-cadquery = callPackage ./cadquery/jupyter-cadquery.nix {};

  ocp-vscode = callPackage ./cadquery/ocp-vscode.nix {};
}
