# ua_robo_final_project
Code for CMU 16748 Underactuated Robotics final project (F18) by Ben Freed, Shuoqi Chen, and Tianyu Wang

Motivation: Traditional controllers, such as the linear quadratic regulator, perform well on many systems; however, if the dynamics of the system are nonlinear, such a control strategy is not globally optimal. If the system state is perturbed sufficiently far from the desired state, control can be poor, or worse yet, the system can become unstable. For particularly nonlinear systems, this can result in small basins of attraction.

In contrast, neural networks trained via reinforcement learning (RL) can approximate globally-optimal policies for highly nonlinear systems. Once the neural network is trained, computation of the policy is efficient, making them well-suited to real-time control. The primary drawback to RL policies is the heavy computational burden during training. This burden is in large part due to the fact that neural networks start with no knowledge of the system dynamics, cost function, or an initial guess for reasonable policies, making it improbable for them to enter regions of the state space during training in which more optimal trajectories lie.

We hypothesize that by combining a traditional controller with a neural network, we can combine many of the benefits of the two techniques. In this case, “combine” will mean the control input at a given time step would either be a weighted sum of the traditional controller and neural network policy, or a weighted random selection from one or the other. We think that providing the system with a “seed” controller that performs well, albeit not optimally, will allow the rollouts to explore more rapidly regions of state space in which better trajectories lie, making it easier for the neural network to learn to improve upon these trajectories. Ultimately, we would like to test whether the proposed hybrid approach results in more optimal and robust control for a nonlinear system, with fewer rollouts needed during training than a neural network policy alone.

Approach: We plan to use an active compass gate walker model as our model system. For our traditional controller, we plan to use a PD controller, similar to the one implemented by Tedrake’s group [2, 3]. We will modify the dynamics of our walker to be stochastic, either by adding a noise process to the dynamics, or by simulating the walker on uneven terrain. Such stochasticity will ensure that the system is occasionally perturbed outside the basin of attraction of the traditional controller. To train the neural network policy, we propose to use evolutionary strategies such as the ones described in [1], because they are straightforward to implement and will probably train quickly enough given the small size of neural network required to control a simple system. We plan to implement and compare 3 seperate controllers: Traditional controller alone Neural network + traditional controller hybrid Neural network alone

Evaluation: We plan to evaluate our approach on the following metrics: Optimality: Does the hybrid system yield policies that incur less cost, on average, than either of the other two controllers? Here, the cost function will likely be based off of that used by Tedrake’s group [2, 3]. We will find the expected cost for each controller by averaging cost incurred over many rollouts of the system controlled by each different controller.

Robustness: Does the basin of attraction increase in size when we add the neural network controller to the traditional controller? We will numerically simulate a deterministic version of the system with initial conditions sampled from the state space. This will allow us to determine from what region of the state space can the system ultimately converge to a stable limit cycle for each of the 3 different controllers, and will define the basin of attraction. A larger basin of attraction indicates a more robust controller.

Learning efficiency: Can the hybrid controller yield better results on the above two metrics after fewer training rollouts than the pure neural net controller?

References 

[1] Salimans, T., Ho, J., Chen, X., and Sutskever, I. (2017). Evolution Strategies as a Scalable Alternative to Reinforcement Learning. ArXiv e-prints.

[2] Byl, Katie, and Russ Tedrake. “Approximate Optimal Control of the Compass Gait on Rough Terrain.” 2008 IEEE International Conference on Robotics and Automation, 2008, doi:10.1109/robot.2008.4543376.

[3] Byl, Katie, and Russ Tedrake. “Metastable Walking Machines.” The International Journal of Robotics Research, vol. 28, no. 8, 2009, pp. 1040–1064., doi:10.1177/0278364909340446.
