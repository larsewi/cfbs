from cfbs.utils import loads_bundlenames


def test_loads_bundlenames_single_bundle():
    policy = """bundle agent bogus
{
  reports:
      "Hello World";
}
"""
    bundles = loads_bundlenames(policy)
    assert len(bundles) == 1
    assert bundles[0] == "bogus"


def test_loads_bundlenames_multiple_bundles():
    policy = """bundle\tagent bogus {
  reports:
      "Bogus!";
}

bundle agent doofus
{
  reports:
      "Doofus!";
}
"""
    bundles = loads_bundlenames(policy)
    assert len(bundles) == 2
    assert bundles[0] == "bogus"
    assert bundles[1] == "doofus"
