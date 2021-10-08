<?php
/**
 * Part of ci-phpunit-test
 *
 * @author     Kenji Suzuki <https://github.com/kenjis>
 * @license    MIT License
 * @copyright  2015 Kenji Suzuki
 * @link       https://github.com/kenjis/ci-phpunit-test
 */

class User_test extends TestCase
{
	public function test_login_correct()
	{
        $params = array(
            'name' => 'dmendoza',
            'psw' => 'DMMHITI7A'
        );
		$output = $this->request('POST', 'cUsuario/cLogin', $params);
        $expected = '"Bienvenid@';
		$this->assertStringContainsString($expected, $output);
	}
    public function test_login_fail()
	{
        $params = array(
            'name' => 'dmendoza',
            'psw' => '123'
        );
		$output = $this->request('POST', 'cUsuario/cLogin', $params);
        $expected = '"Error al ingresa';
		$this->assertStringContainsString($expected, $output);
	}
    public function test_login_conected(){
            $this->request('GET', 'cUsuario/cLogin');
            $this->assertResponseCode(200);
    }
    public function test_login_404(){
        $this->request('GET', 'cUsuario/cLoginEntry');
        $this->assertResponseCode(404);
}

}
