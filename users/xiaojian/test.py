import lm_eval
import lm_eval.api
import lm_eval.api.registry

def test():

    # print(lm_eval.models)
    print(lm_eval.api.registry.MODEL_REGISTRY)


if __name__ == "__main__":
    test()


