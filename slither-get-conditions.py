import sys
from slither.slither import Slither

def looks_like_state_check(contract, node):
    for v in contract.variables:
        if v in node.variables_read:
            return True

    return False

def main(args):
    if len(args) < 2:
        print("Usage: python get-conditions.py FILENAME")
        exit(1)

    slither = Slither(args[1])

    for contract in slither.contracts:
        # print('Contract: '+ contract.name)

        for function in contract.functions:
            # print('Function: {}'.format(function.name))

            for node in function.nodes:
                # NOTE: This will also give `return bool;` as a condition. I'm not sure that this really should count, so I used a different machnism to get this information.
                # if node.is_conditional():
                #     print(node)

                if node.contains_if() or node.contains_require_or_assert():
                    print(looks_like_state_check(contract, node), node)

if __name__ == '__main__':
    main(sys.argv)

