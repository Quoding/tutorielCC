import torch
import torch.nn as nn

class TestModel(nn.Module):
    def __init__(self):
        super().__init__()
        self.layers = nn.Sequential(
                    nn.Linear(32, 16),
                    nn.Linear(16, 8),
                    nn.Linear(8, 1)
                )

    def forward(self, x):
        return self.layers(x)

model = TestModel()

print("Model layers:")
print(model.layers)
print()

tns = torch.normal(0, 1, (32,))
print("Random tensor:")
print(tns)
print()

print("Model output:")
print(model(tns))


torch.save(model.state_dict(), "/home/user01/projects/def-sponsor00/user01/tutorielCC/models/test_model.pth")
