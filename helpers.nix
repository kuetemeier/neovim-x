{
  mkMapCmd = actionStr: description: {
    silent = true;
    action = "<cmd>${actionStr}<CR>";
    inherit description;
  };
}
