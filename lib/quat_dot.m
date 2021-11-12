function qd = quat_dot(q, omega)
            %UnitQuaternion.dot UnitQuaternion derivative in world frame
            %
            % QD = Q.dot(omega) is the rate of change of the UnitQuaternion Q expressed 
            % as a Quaternion in the world frame. Q represents the orientation of a body
            % frame with angular velocity OMEGA (1x3).
            %
            % Notes::
            % - This is not a group operator, but it is useful to have the result as a
            %   Quaternion.
            %
            % Reference::
            %  - Robotics, Vision & Control, 2nd edition, Peter Corke, pp.64.
            %
            % See also UnitQuaternion.dotb.
            
            % UnitQuaternion.pure(omega) * q
            
            q = q(:);
            
            E = q(1)*eye(3,3) - skew(q(2:4));
            omega = omega(:);
            qd = 0.5 * [-q(2:4)'*omega; E*omega];
 end