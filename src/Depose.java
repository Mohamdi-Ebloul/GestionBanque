import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.swing.*;
public class Depose extends JFrame {
	Container c;
	JLabel l11,l,l6,l12,l13,l10;
	static JTextField t1,t2,t3;
	JButton b,b1,b2,b10;
	JPanel p;
	
	public Depose() {
		c=this.getContentPane();
		setLayout(new FlowLayout());
		p=new JPanel();
		l= new JLabel("Manupiler un compte");
		l11= new JLabel("Entrer le numéro de compte");
		l12= new JLabel("Entrer le lmontant");
		l13= new JLabel("Entrer votre identifiant (l'id de l'agent)");
		b1=new JButton("Rétirer");
		l6= new JLabel("Manupiler un compte ");
		t1= new JTextField(50);
		t2= new JTextField(50);
		t3= new JTextField(50);
		b10=new JButton("Transferer");
		l10=new JLabel("Aller d'ici pour transferer l'argent");
		b=new JButton("Déposer");
		
		l.setVerticalAlignment(JLabel.TOP);
		p.setLayout(new GridLayout(9, 8));
		add(l);
		add(p);
		
		p.add(l11);p.add(t1);
		p.add(l12);p.add(t2);
		p.add(l13);p.add(t3);
		p.add(b);
		
		
		p.add(b1);
		add(l10);
		add(b10);
		l.setFont(new java.awt.Font("Times New Roman", 0, 24));
		 
		b.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                bActionPerformed(evt);
            }
            
        });
		b1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                b1ActionPerformed(evt);
            }
            
        });
	
		b10.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                b10ActionPerformed(evt);
            }
            
        });

		setSize(500,500);
		setVisible(true);
	}
	private void bActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton5ActionPerformed
		String driver="oracle.jdbc.OracleDriver";
		String jdbc_url="jdbc:oracle:thin:@//localhost:1521/XE";
		String user="System";
		String pwd="12345678";
		
		 try {
	        	Class.forName(driver);
	    		Connection con=DriverManager.getConnection(jdbc_url,user,pwd);
	    		CallableStatement st=con.prepareCall("{CALL DEPOSER(?,?,?)}");
	    		st.setString(1, t1.getText());
	    		st.setString(2, t2.getText());
	    		st.setString(3, t3.getText());
	    		st.execute();
	        	JOptionPane.showMessageDialog(this, "L'argent est déposé  avec succès");
	        } catch (Exception e) {
	            JOptionPane.showMessageDialog(null, "ereur operation");
	        }


    }//GEN-LAST:event_jButton5ActionPerformed
	private void b1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton5ActionPerformed
		String driver="oracle.jdbc.OracleDriver";
		String jdbc_url="jdbc:oracle:thin:@//localhost:1521/XE";
		String user="System";
		String pwd="12345678";
		
		 try {
	        	Class.forName(driver);
	    		Connection con=DriverManager.getConnection(jdbc_url,user,pwd);
	    		CallableStatement st=con.prepareCall("{CALL RETIER(?,?,?)}");
	    		st.setString(1, t1.getText());
	    		st.setString(2, t2.getText());
	    		st.setString(3, t3.getText());
	    		st.execute();
	        	JOptionPane.showMessageDialog(this, "L'argent est rétiré  avec succès");
	        } catch (Exception e) {
	            JOptionPane.showMessageDialog(null, "ereur operation");
	        }


    }//GEN-LAST:event_jButton5ActionPerformed
	private void b10ActionPerformed(java.awt.event.ActionEvent evt) {
		Transferer obj1=new Transferer();
		obj1.setVisible(true);
		this.hide();
		
	}

	public static void inserData(String sql) throws Exception {
		
		
	}

}