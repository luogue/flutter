void main() {
  Map a = {
    'a': 1,
    'b': 2,
  };
  a.map((prop, value) {
    print ('prop：$prop');
    print ('value：$value');
    return prop.toUpperCase();
  });
}
